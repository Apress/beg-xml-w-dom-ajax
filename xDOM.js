//xDOM Cross Platform DOM and XMLHTTP Factory
//Requires browserDetect.js

//Global Variables/Constants
//Outer function
function xDOM() { }
//Declare an array of ProgIDs for creating MSXML objects.
//In version order so that we always create the most recent version
// also declare a string to hold the correct ProgID when we find it.
var arrMSXMLProgIDs = ["MSXML4.DOMDocument", "MSXML3.DOMDocument", "MSXML2.DOMDocument", "MSXML.DOMDocument", "Microsoft.XmlDom"];
var strMSXMLProgID;
var blnFailed = false;
var strFailedReason;


//Global initialisation code. Run on page load

//Internet Explorer initialization
if (is_ie) {
    var blnSuccess = false;
    
    //iterate through array of ProgIDs
    for (var i=0; i < arrMSXMLProgIDs.length && !blnSuccess; i++) {
    
        //Try to create the ActiveX Object at this index
        try {
			//If this fails we will leave the try and go to the catch
            var oDOMDocument = new ActiveXObject(arrMSXMLProgIDs[i]);
            //If we have not left the try then initialize the variables
            strMSXMLProgID = arrMSXMLProgIDs[i];
            //And set the success flag so that we stop looping
            blnSuccess = true;               
        
        } catch (oException) {
			//Do nothing. We just want to keep on looping. We will check for a Sucess further down.
        }
    }
    
    
    //Check there was success, set the failed flag and reason.
    if (!blnSuccess	){
       blnFailed = true;
       strFailedReason = "No suitable MSXML library on machine.";
    }
}	
//Set up any necessary stuff for Mozilla (Gecko) based browsers.
else if (is_gecko) {

	/*No need to detect DOM support because we can assume that it exists.
	  
	  Here we are adding some method prototypes to extend the Mozilla object 
	  model to mimic that of IE
	  TODO: Find a decent reference for Javascript
	  */
	
    //Document class
    
    //load() (Override)
    //Keep the original method as we need to call it later
    Document.prototype.__load__ = Document.prototype.load;
    //...and add the overiding prototype
    Document.prototype.load = _Moz_Document_load;
    
    //loadXML()
    Document.prototype.loadXML = _Moz_Document_loadXML;
    
    //readyState
    Document.prototype.readyState = 0;
    
    //parseError
    Document.prototype.parseError = 0;
    
    //onreadystatechange
    Document.prototype.onreadystatechange = null;
    
    //Node Class
    
    //Note that there are issues with some versions of Mozilla not binding these prototypes correctly
    
    //transformNode()
    Node.prototype.transformNode = _Moz_node_transformNode;
    
    //=transformNodeToObject()
    Node.prototype.transformNodeToObject = _Moz_node_transformNodeToObject;
    
    //xml (This is a read only property so no need for a setter)
    Node.prototype.__defineGetter__("xml", _Moz_Node_getXML);
          
}
else {
	//No support for DOM
	//Set failed flag
	blnFailed = true;
    strFailedReason = "Browser has no DOM support.";
}

//Function to allow cross browser creation of DOMDocument
xDOM.createDOMDocument = function() {

    var oOutDOMDocument = null;
    
    //determine if this is a standards-compliant browser like Mozilla
    if (is_gecko) {
    
        //create the DOM Document the standards way
        oOutDOMDocument = document.implementation.createDocument("", "", null);    
    
        //add an event listener for the load event so that we can handle it like IE does.
		//Parameters are the event type, the listener that we have declared in the xDOM
		//library and useCapture which we set to false. See the Mozilla Documentation for 
		//more on the addEventListener method.
        oOutDOMDocument.addEventListener("load", document_onload, false);
        
    } else if (is_ie) {
    
        //create the DOM Document the IE way
        oOutDOMDocument = new ActiveXObject(strMSXMLProgID);
        
        //Enable MSXML preserveWhiteSpace so that MSXML DOM behaves like Mozilla with regard to whitespace nodes.
        oOutDOMDocument.preserveWhiteSpace = true;
        
    }
    
    //return the object
    return oOutDOMDocument;
}
	

//Implementation for Mozilla Object Model Extensions


//loadXML Impl
function _Moz_Document_loadXML(strXML) {
    
        //change the readystate of 'this' DOMDocument
        updateReadyState(this, 1);

        //create an XMLExtras DOMParser
        var oDOMParser = new DOMParser();
        
        //create new document from string
        var oDOM = oDOMParser.parseFromString(strXML, "text/xml");
        
        //Clear 'this' DOMDocument
		while (this.hasChildNodes())
			this.removeChild(this.lastChild);
            
        //Copy the nodes from the newly parsed DOMDocument to 'this' DOMDocument
        for (var i=0; i < oDOM.childNodes.length; i++) {
            
            //import the node
            var oImportNode = this.importNode(oDOM.childNodes[i], true);
            
            //append to 'this' DOMDocument
            this.appendChild(oImportNode);
        
        }
        
        //Fire the onload event manually
        fireOnLoad(this);  
} 


//load Impl. This overrides the usual Mozilla load()
//Note that load() method is still non standard per the DOM spec
function _Moz_Document_load(strURL) {

    //Clear the parse error
    this.parseError = 0;

    //update the readyState	to Loading	
    updateReadyState(this, 1);
    
    //Call original load method in a try catch block
    try {
        this.__load__(strURL); 
    } catch (oException) {
        //set the parseError
        this.parseError = -1;
    }
    
    //change the readystate
    updateReadyState(this, 4);
}

//onload event handler Impl
function document_onload() {
    fireOnLoad(this);
}

function fireOnLoad(oDOMDocument) {
    //check for a parser error
    if (!oDOMDocument.documentElement || oDOMDocument.documentElement.tagName == "parsererror")
        oDOMDocument.parseError = -1;

    //change the readyState
    updateReadyState(oDOMDocument, 4);
}


function _Moz_node_transformNode(oStylesheetDOM) {
	
	//Create an XSLTProcessor Object
	var oXSLTProcessor = new XSLTProcessor();
	//Create a DOMDocument to receive output
	var oOutDOM = document.implementation.createDocument("","",null);
	//Perform the transform
	oXSLTProcessor.transformDocument( this, oStylesheetDOM, oOutDOM, null);

	//Return serialization of OutDOM
	return (new XMLSerializer()).serializeToString(oOutDOM);
}

function _Moz_node_transformNodeToObject(oStylesheetDOM,oOutputDOM) {
	
	//Create an XSLTProcessor Object
	var oXSLTProcessor = new XSLTProcessor();
	//Perform the transform
	oXSLTProcessor.transformDocument( this, oStylesheetDOM, oOutputDOM, null);

    //change the readystate
    updateReadyState(oOutputDOM, 4);
    	
	return 1;
}

//Get XML property getter function
function _Moz_Node_getXML() {
	//Use XMLExtras XMLSerializer to return a the serialzide contents of 'this' node.
   return (new XMLSerializer()).serializeToString(this);
}

//Misc private functions

//Function to change ready state and fire event handler if necessary
function updateReadyState(oDOMDocument, intReadyState) {
	//See MS for documentation on readyState property
    oDOMDocument.readyState = intReadyState;
    
    if (oDOMDocument.onreadystatechange != null && typeof oDOMDocument.onreadystatechange == "function")
        oDOMDocument.onreadystatechange();
}

module.exports = {

	pluginName: "NativeLogs",

	getLog:function(_nbLines,_bCopyToClipboard,successCB,failureCB){
		cordova.exec(successCB, failureCB, this.pluginName,"getLog", [_nbLines,_bCopyToClipboard]);
	}
};




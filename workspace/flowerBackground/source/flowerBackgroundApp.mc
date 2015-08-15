using Toybox.Application as App;
using Toybox.System as Sys;

class flowerBackgroundApp extends App.AppBase {

	hidden var mView;
    //! onStart() is called on application start up
    function onStart() {
	   	mView=new flowerBackgroundView();
    	mView.setupImages();
    	setupHistory();
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    Sys.println("onStop");
    	saveHistory();
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ mView ];
    }
      
	
	function setupHistory(){
	    Sys.println("setupHistory");
		var value=getProperty("flowerHistory");
    	if( (value instanceof (Toybox.Lang.Dictionary)) && value.hasKey("main")){
    		mView.imgHistory=value;
    	}
    	else{
    	    mView.setupImgHistory();
			saveHistory();
    	}
	}
	
	
	function saveHistory(){
        Sys.println("saveHistory");
        var value=mView.imgHistory;
    	setProperty("flowerHistory", value);
    	saveProperties();
    	Sys.println("value "+value);
    }  

}
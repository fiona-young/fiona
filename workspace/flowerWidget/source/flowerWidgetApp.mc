using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class flowerWidgetApp extends App.AppBase {

	hidden var mView;
    //! onStart() is called on application start up
    function onStart() {
	   	mView=new flowerWidgetView();
    	mView.setupImages();
    	setupHistory();
   // mView.color=Toybox.Graphics.COLOR_RED;
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    Sys.println("onStop");
    	saveHistory();
    }
	
	function setupHistory(){
	    Sys.println("setupHistory");
		var value=getProperty("flowerHistory");
    	if( (value instanceof (Toybox.Lang.Dictionary)) && value.hasKey("main")){
    		mView.imgHistory=value;
    	}
    	else{
    	    mView.setupImgHistory();
			saveView();
    	}
	}
	

    //! Return the initial view of your application here
    function getInitialView() {
    Sys.println("initial");

     var mDelegate=new flowerWidgetDelegate();
     mDelegate.attachView(mView);
    	
        return [ mView, mDelegate ];
    }
    
    function saveHistory(){
        Sys.println("saveHistory");
        var value=mView.imgHistory;
    	setProperty("flowerHistory", value);
    	saveProperties();
    	Sys.println("value "+value);
    }  

}

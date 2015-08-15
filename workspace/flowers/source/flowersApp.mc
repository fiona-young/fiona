using Toybox.Application as App;
using Toybox.System as Sys;

class flowersApp extends App.AppBase {

	hidden var mView;
    //! onStart() is called on application start up
    function onStart() {
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    Sys.println("onStop");
    	saveView();
    }

    //! Return the initial view of your application here
    function getInitialView() {
    Sys.println("initial");
        mView=new flowersView();
    	mView.setupImages();
    	var value=getProperty("imgHistory");
    	if( (value instanceof (Toybox.Lang.Dictionary)) && value.hasKey("main")){
    	   	value["showing"]=null;
    		mView.imgHistory=value;
    	}
    	else{
    	    mView.setupImgHistory();
			saveView();
    	}
        return [ mView ];
    }
    
    function saveView(){
        	var value=mView.imgHistory;
    	    value["showing"]=null;
    		setProperty("imgHistory", value);
    		saveProperties();
    		Sys.println("value "+value + (value instanceof (Toybox.Lang.Dictionary)));
    }  

}
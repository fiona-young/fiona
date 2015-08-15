using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.Application as App;

class flowerWidgetView extends Ui.View {
    var bitmap;
    var imgHistory={};
    var count;
    var images;
    var showing=null;
    var color= Gfx.COLOR_BLACK;


	function rand(min, max){
	    var maxNum=2147483647.0;
	    return ((Toybox.Math.rand()/maxNum)*(1+max-min)+min).toNumber();
	
	}

    //! Load your resources here
    function onLayout(dc) {
    setLayout(Rez.Layouts.MainLayout(dc));

    }
    
        //! Update the view
    function onUpdate(dc) {
    	//Sys.println(imgHistory);
        var clockTime = Sys.getClockTime();
		//checkIfTimeForNextImage(clockTime);

		drawBitmap(dc,clockTime);

    }   
    
    function setLoop(val){
    	if(val>count){
    		val=val-count;
    		val=setLoop(val);
    	}
    	else if(val<1){
    		val=count+val;
    		val=setLoop(val);
    	}
    	return val;
    }
    
    
    function setupImages(){
      	images = [ 	Rez.Drawables.image01,
                 	Rez.Drawables.image02,
                 	Rez.Drawables.image03,
                 	Rez.Drawables.image04,
                 	Rez.Drawables.image05,
                 	Rez.Drawables.image06,
                 	Rez.Drawables.image07,
                 	Rez.Drawables.image08,
                 	Rez.Drawables.image09,
                 	Rez.Drawables.image10,
                 	Rez.Drawables.image11,
                 	Rez.Drawables.image12,
                 	Rez.Drawables.image13,
                 	Rez.Drawables.image14,
                 	Rez.Drawables.image15,
                 	Rez.Drawables.image16,
                 	Rez.Drawables.image17,
                 	Rez.Drawables.image18,
                 	Rez.Drawables.image19,
                 	Rez.Drawables.image20,
                 	Rez.Drawables.image21,
                 	Rez.Drawables.image22,
                 	Rez.Drawables.image23,
                 	Rez.Drawables.image24,
                 	Rez.Drawables.image25,
                 	Rez.Drawables.image26,
                 	Rez.Drawables.image27,
                 	Rez.Drawables.image28,
                 	Rez.Drawables.image29];
    	count=images.size();
        //Sys.println(imgHistory);
                 
    }
    
    function setupImgHistory(){
    	showing=null;
        imgHistory["main"]=rand(0,count-1);
        imgHistory["changed"]=Time.now().value();
        Sys.println("imgHistory "+imgHistory);
    }
    
    function setNextImage(changeTime){
		changeImage(changeTime,+1);
    }
    
   function setLastImage(changeTime){
		changeImage(changeTime,-1);
    }
    
     function changeImage(changeTime,step){
		
        imgHistory["main"]=setLoop(imgHistory["main"]+step);
        if(changeTime){
        	imgHistory["changed"]=Time.now().value();
        }
        Sys.println("changing "+imgHistory+" "+changeTime);
    }
    
    function requestState(clockTime){
    var limit=5;
     if(clockTime.min%60<limit){
 //     Sys.println("onHour");
        	return setLoop(imgHistory["main"]+count/2);
        }
    	else{
    	   //   Sys.println("main ");
    		return imgHistory["main"];
    	}
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    	App.getApp().setupHistory();
    }
    
    function drawBitmap(dc,clockTime){
    	var request=requestState(clockTime);
    	if (request != showing){
			showing=request;
			bitmap=null;
			bitmap = Ui.loadResource(images[request]);
		}
		dc.drawBitmap(0,0, bitmap);
    }



    
    

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
        	App.getApp().saveHistory();
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
  
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}

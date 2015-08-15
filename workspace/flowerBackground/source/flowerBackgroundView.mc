using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.Application as App;
class flowerBackgroundView extends Ui.WatchFace {
    var bitmap;
    var imgHistory={};
    var count;
    var images;
    var showing=null;


	function rand(min, max){
	    var maxNum=2147483647.0;
	    return ((Toybox.Math.rand()/maxNum)*(1+max-min)+min).toNumber();
	
	}

    //! Load your resources here
    function onLayout(dc) {
    //Sys.println(Time.now().value()+" time ");
    setLayout(Rez.Layouts.WatchFace(dc));

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
    	//if(!imgHistory.hasKey("main")){
        	imgHistory["main"]=rand(0,count-1);
        	imgHistory["onHour"]=setLoop(imgHistory["main"]+count/2);
        	imgHistory["changed"]=Time.now().value();
       // }
    }
    
    function checkIfTimeForNextImage(clockTime){
    	var secondsSinceLastChange=Time.now().value()-imgHistory["changed"];
    	var hourString = clockTime.hour.format("%02i");
        var minuteString = clockTime.min.format("%02i");
    	Sys.println("time "+hourString+":"+minuteString+" secondsSinceLastChange "+imgHistory+" hours:"+((secondsSinceLastChange.toFloat())/Gregorian.SECONDS_PER_HOUR).format("%.2f")+ " secs: "+secondsSinceLastChange);
    	var changesOnHours={9=>9,17=>17,22=>22};
    	var secondsMinChange=Gregorian.SECONDS_PER_HOUR*3;
    	var secondsForceChange=Gregorian.SECONDS_PER_HOUR*18;
    	if((changesOnHours.hasKey(clockTime.hour)) && (secondsSinceLastChange>secondsMinChange)){
    	//if((clockTime.min%3==0) && (secondsSinceLastChange>secondsMinChange)){
    		setNextImage();
    	}
    	else if(secondsSinceLastChange>secondsForceChange){
    		setNextImage();
    	}
    }
    
    function setNextImage(){

        imgHistory["main"]=setLoop(imgHistory["main"]+1);
        imgHistory["onHour"]=setLoop(imgHistory["onHour"]+1);
        imgHistory["changed"]=Time.now().value();
        Sys.println("changing "+imgHistory);
    }
    
    function requestState(clockTime){
    var limit=5;
     if(clockTime.min%60<limit){
 //     Sys.println("onHour");
        	return imgHistory["onHour"];
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
       // App.getApp().setupHistory();
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


    //! Update the view
    function onUpdate(dc) {
    	//Sys.println(imgHistory);
        var clockTime = Sys.getClockTime();
		checkIfTimeForNextImage(clockTime);
		drawBitmap(dc,clockTime);
		drawTimeText(dc,clockTime);

    }   
    

    function drawTimeText(dc,clockTime){
        // Get and show the current time
        var hourString = clockTime.hour.format("%02i");
        var minuteString = clockTime.min.format("%02i");
        var time=Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = time.month+" "+time.day.format("%02i");
		var batteryString=Sys.getSystemStats().battery.format("%i")+"%";
		
		 dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
		fillRoundedRectangleFromCenter(dc,dc.getWidth()/2, 190, 86, 38, 5);
		fillRoundedRectangleFromCenter(dc,dc.getWidth()/2, 32, 84, 22, 5);
		fillRoundedRectangleFromCenter(dc,dc.getWidth()/2, 12, 45, 22, 5);
		
		var timeText=View.findDrawableById("TimeLabel"); 
		timeText.setText(hourString+":"+minuteString);
		timeText.draw(dc);
		var dayText=View.findDrawableById("DayLabel"); 
		dayText.setText(time.day_of_week+" "+dateString);
		dayText.draw(dc);
		var batteryText=View.findDrawableById("BatteryLabel"); 
		batteryText.setText(batteryString);
		batteryText.draw(dc);
		
    }
    

    
    function fillRoundedRectangleFromCenter(dc,midX,midY,dx,dy,r){
    	var x=midX-(dx/2);
    	var y=midY-(dy/2);
   		dc.fillRoundedRectangle(x, y, dx, dy, r);
    }
    

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    	//App.getApp().saveHistory();
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
  
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}

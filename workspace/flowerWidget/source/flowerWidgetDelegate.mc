using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class flowerWidgetDelegate extends Ui.BehaviorDelegate {
var mView;
		function attachView(view) {
		 mView=view;
		 Sys.println("initialise"+mView.imgHistory);
		}
        function onKey(key) {
         Sys.println("onKey"+key.getKey());
         if(key.getKey()==Ui.KEY_ENTER){
         	mView.setNextImage(false);
         	Ui.requestUpdate();
          	Sys.println("keyenter"+mView.imgHistory);
         }
         else if(key.getKey()==Ui.KEY_ESC){
         	mView.setLastImage(false);
         	Ui.requestUpdate();
          	Sys.println("keyesc"+mView.imgHistory);
         }
 
    }
}
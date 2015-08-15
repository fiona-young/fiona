using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class flowerKeyDelegate extends Ui.BehaviorDelegate {

        function onKey(key) {
         Sys.println("onKey"+key.getKey());
 
    }
}
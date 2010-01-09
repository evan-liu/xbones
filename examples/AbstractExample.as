package {
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  /**
   * @author eidiot
   */
  public class AbstractExample extends Sprite {
    //==========================================================================
    //  Constructor
    //==========================================================================
    public function AbstractExample() {
      super();
      var assetLoader:Loader = new Loader();
      assetLoader.contentLoaderInfo.addEventListener(
          Event.COMPLETE, assetLoader_completeHandler);
      assetLoader.load(new URLRequest("../assets/cs4skin.swf"),
                       new LoaderContext(false, ApplicationDomain.currentDomain));
    }
    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function assetLoader_completeHandler(event:Event):void {
      LoaderInfo(event.target).removeEventListener(
          Event.COMPLETE, assetLoader_completeHandler);
      run();
    }
    //==========================================================================
    //  Protected methods
    //==========================================================================
    protected function run():void {
    }
  }
}
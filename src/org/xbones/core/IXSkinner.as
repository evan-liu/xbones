package org.xbones.core {
  import flash.display.DisplayObject;
  /**
   * Interface for the skin set for a bone (ui control like a button)
   * or one of its states (like CheckBox).
   *
   * @author eidiot
   */
  public interface IXSkinner {
    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  upSkin
    //----------------------------------
    /**
     * skin for the background and border when the mouse is not over the bone.
     */
    function get upSkin():DisplayObject;
    //----------------------------------
    //  overSkin
    //----------------------------------
    /**
     * skin for the background and border when the mouse is over the bone.
     */
    function get overSkin():DisplayObject;
    //----------------------------------
    //  downSkin
    //----------------------------------
    /**
     * skin for the background and border when the mouse button is down.
     */
    function get downSkin():DisplayObject;
    //----------------------------------
    //  disabledSkin
    //----------------------------------
    /**
     * skin for the background and border when the bone is disabled.
     */
    function get disabledSkin():DisplayObject;
  }
}
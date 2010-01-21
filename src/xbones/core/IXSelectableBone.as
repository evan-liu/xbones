package xbones.core
{
    //----------------------------------
    //  Events
    //----------------------------------
    /**
     * Dispatched when the selected state changes.
     * @eventType flash.events.Event.CHANGE
     */
    [Event(name="change", type="flash.events.Event")]

    /**
     * Interface for selectable bones.
     * @author eidiot
     */
    public interface IXSelectableBone extends IXInteractiveBone
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  selected
        //------------------------------
        /**
         * If the bone is selected.
         */
        function get selected():Boolean;
        /**
         * @private
         */
        function set selected(value:Boolean):void;
        //------------------------------
        //  data
        //------------------------------
        /**
         * Data of the selectalbe bone.
         */
        function get data():Object;
        /**
         * @private
         */
        function set data(value:Object):void;
    }
}
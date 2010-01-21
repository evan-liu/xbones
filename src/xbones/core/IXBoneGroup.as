package xbones.core
{
    //----------------------------------
    //  Events
    //----------------------------------
    /**
     * Dispatched when the selected RadioButton bone changes.
     * @eventType flash.events.Event.CHANGE
     */
    [Event(name="change", type="flash.events.Event")]

    /**
     * Interface for bone groups.
     * @author eidiot
     */
    public interface IXBoneGroup extends IXInteractiveBone
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  selection
        //------------------------------
        /**
         * currently selected bone in the group.
         */
        function get selection():IXSelectableBone;
        /**
         * @private
         */
        function set selection(value:IXSelectableBone):void;
        //------------------------------
        //  selectedValue
        //------------------------------
        /**
         * Value of the selected bone.
         */
        function get selectedValue():Object;
        /**
         * @private
         */
        function set selectedValue(value:Object):void;
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Add a bone to this group.
         * @param bone      The bone to be added to this group.
         * @param select    If select this bone.
         */
        function add(bone:IXSelectableBone, select:Boolean = false):void;
        /**
         * Remove a bone from the group.
         * @param bone  The bone to be removed from this group.
         */
        function remove(bone:IXSelectableBone):void;
    }
}
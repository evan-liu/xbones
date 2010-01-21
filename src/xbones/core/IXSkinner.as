package xbones.core
{
    /**
     * Interface for the skin set for a bone (ui control like a button)
     * or one of its states (like CheckBox).
     *
     * @author eidiot
     */
    public interface IXSkinner
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  bone
        //------------------------------
        /**
         * The bone to be skinned.
         */
        function get bone():IXWithSkinBone;
        /**
         * @private
         */
        function set bone(value:IXWithSkinBone):void;
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Show the mouse up state.
         */
        function up():void;
        /**
         * Show the mouse over state.
         */
        function over():void;
        /**
         * Show the mouse down state.
         */
        function down():void;
        /**
         * Show the disabled state.
         */
        function disabled():void;
    }
}
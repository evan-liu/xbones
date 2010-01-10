package org.xbones.core
{
    import flash.events.IEventDispatcher;
    /**
     * Interface for interactive bones.
     * @author eidiot
     */
    public interface IXInteractiveBone extends IEventDispatcher
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  enabled
        //------------------------------
        /**
         *  Whether the bone can accept user interaction.
         */
        function get enabled():Boolean;
        /**
         *  @private
         */
        function set enabled(value:Boolean):void;
    }
}
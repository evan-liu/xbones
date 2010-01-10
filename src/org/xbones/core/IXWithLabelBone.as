package org.xbones.core
{
    import flash.text.TextFormat;
    /**
     * Interface for bones with label.
     * @author eidiot
     */
    public interface IXWithLabelBone
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  labelText
        //------------------------------
        /**
         * Label text of the button.
         */
        function get labelText():String;
        /**
         * @private
         */
        function set labelText(value:String):void;
        //------------------------------
        //  format
        //------------------------------
        /**
         * Text format of the label.
         */
        function get labelFormat():TextFormat;
        /**
         * @private
         */
        function set labelFormat(value:TextFormat):void;
    }
}
package org.xbones.skins
{
    import org.xbones.core.IXSelectableSkinner;
    import org.xbones.core.IXSkinner;

    import flash.system.ApplicationDomain;
    /**
     * @author eidiot
     */
    public class XReflectionSelectableSkinner implements IXSelectableSkinner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XReflectionSelectableSkinner</code>.
         * @param boneName          Name of the bone like "Button".
         * @param applicationDomain <code>ApplicationDomain</code> to get definitions
         *                          of the skins.
         */
        public function XReflectionSelectableSkinner(boneName:String,
                                     applicationDomain:ApplicationDomain = null)
        {
            _normalSkinner = new XReflectionSkinner(boneName, applicationDomain);
            _selectedSkinner = new XReflectionSkinner(boneName + "_selected",
                                                      applicationDomain);
        }
        //======================================================================
        //  Properties: IXSelectableSkinner
        //======================================================================
        //------------------------------
        //  normalSkinner
        //------------------------------
        private var _normalSkinner:IXSkinner;
        /**
         * @inheritDoc
         */
        public function get normalSkinner():IXSkinner
        {
            return _normalSkinner;
        }
        //------------------------------
        //  selectedSkinner
        //------------------------------
        private var _selectedSkinner:IXSkinner;
        /**
         * @inheritDoc
         */
        public function get selectedSkinner():IXSkinner
        {
            return _selectedSkinner;
        }
    }
}
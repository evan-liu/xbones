package xbones.bones
{
    import xbones.core.IXBoneGroup;
    import xbones.core.IXSelectableBone;

    import flash.events.Event;
    import flash.events.EventDispatcher;

    //----------------------------------
    //  Events
    //----------------------------------
    /**
     * Dispatched when the selected RadioButton bone changes.
     * @eventType flash.events.Event.CHANGE
     */
    [Event(name="change", type="flash.events.Event")]

    /**
     * A group of RadioButton bones.
     * @author eidiot
     */
    public class XRadioButtonGroup extends EventDispatcher implements IXBoneGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XRadioButtonGroup</code>.
         */
        public function XRadioButtonGroup()
        {
            super();
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var boneList:Array = [];
        //======================================================================
        //  Properties: IXBoneGroup
        //======================================================================
        //------------------------------
        //  selection
        //------------------------------
        private var _selection:IXSelectableBone;
        /**
         * @inheritDoc
         */
        public function get selection():IXSelectableBone
        {
            return _selection;
        }
        /**
         * @private
         */
        public function set selection(value:IXSelectableBone):void
        {
            if (!value || value == _selection)
            {
                return;
            }
            if (_selection)
            {
                _selection.selected = false;
            }
            _selection = value;
            _selection.selected = true;
            dispatchEvent(new Event(Event.CHANGE));
        }
        //------------------------------
        //  selectedValue
        //------------------------------
        /**
         * @inheritDoc
         */
        public function get selectedValue():Object
        {
            if (_selection)
            {
                return _selection.data;
            }
            return null;
        }
        /**
         * @private
         */
        public function set selectedValue(value:Object):void
        {
            if (!value)
            {
                return;
            }
            for each (var bone:IXSelectableBone in boneList)
            {
                if (bone.data == value)
                {
                    selection = bone;
                    return;
                }
            }
        }
        //------------------------------
        //  enabled
        //------------------------------
        private var _enabled:Boolean = true;
        /**
         * @inheritDoc
         */
        public function get enabled():Boolean
        {
            return _enabled;
        }
        /**
         * @private
         */
        public function set enabled(value:Boolean):void
        {
            if (value == _enabled) 
            {
            	return;
            }
            _enabled = value;
            for each (var bone:IXSelectableBone in boneList) 
            {
                bone.enabled = _enabled;
            }
        }
        //======================================================================
        //  Public methods: IXBoneGroup
        //======================================================================
        /**
         * @inheritDoc
         */
        public function add(bone:IXSelectableBone, select:Boolean = false):void
        {
            if (!bone || boneList.indexOf(bone) != -1)
            {
                return;
            }
            boneList.push(bone);
            bone.addEventListener(Event.CHANGE, bone_changeHandler);
            if (select)
            {
                selection = bone;
            }
            else
            {
                bone.selected = false;
            }
            bone.enabled = _enabled;
        }
        /**
         * @inheritDoc
         */
        public function remove(bone:IXSelectableBone):void
        {
            var index:int = boneList.indexOf(bone);
            if (index == -1)
            {
                return;
            }
            boneList.splice(index, 1);
            if (_selection == bone)
            {
                _selection = null;
            }
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function bone_changeHandler(event:Event):void
        {
            var changedBone:IXSelectableBone = IXSelectableBone(event.target);
            if (changedBone.selected)
            {
                if (changedBone != _selection)
                {
                    selection = changedBone;
                }
                return;
            }
            if (changedBone == _selection)
            {
                _selection = null;
            }
        }
    }
}
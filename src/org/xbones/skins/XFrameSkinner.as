package org.xbones.skins
{
    import org.xbones.core.IXSkinner;
    import org.xbones.core.IXWithSkinBone;

    import flash.display.MovieClip;
    /**
     * Skinner use frames of a MovieClip.
     * @author eidiot
     */
    public class XFrameSkinner implements IXSkinner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XFrameSkinner</code>.
         */
        public function XFrameSkinner(movie:MovieClip, upFrame:int = 1,
                                      overFrame:int = 2, downFrame:int = 3,
                                      disabledFrame:int = 4)
        {
            this.movie = movie;
            const MAX:int = movie.totalFrames;
            this.upFrame = Math.min(MAX, upFrame);
            this.overFrame = overFrame > MAX ? upFrame : overFrame;
            this.downFrame = downFrame > MAX ? upFrame : downFrame;
            this.disabledFrame = disabledFrame > MAX ? upFrame : disabledFrame;
        }
        //======================================================================
        //  Variables
        //======================================================================
        protected var movie:MovieClip;
        protected var upFrame:int;
        protected var overFrame:int;
        protected var downFrame:int;
        protected var disabledFrame:int;
        //======================================================================
        //  Properties: IXSkinner
        //======================================================================
        protected var _bone:IXWithSkinBone;
        /**
         * @inheritDoc
         */
        public function get bone():IXWithSkinBone
        {
            return _bone;
        }
        /**
         * @private
         */
        public function set bone(value:IXWithSkinBone):void
        {
            _bone = value;
        }
        //======================================================================
        //  Public methods: IXSkinner
        //======================================================================
        /**
         * @inheritDoc
         */
        public function up():void
        {
            if (_bone && movie)
            {
                movie.gotoAndStop(upFrame);
                _bone.applySkin(movie);
            }
        }
        /**
         * @inheritDoc
         */
        public function over():void
        {
            if (_bone && movie)
            {
                movie.gotoAndStop(overFrame);
                _bone.applySkin(movie);
            }
        }
        /**
         * @inheritDoc
         */
        public function down():void
        {
            if (_bone && movie)
            {
                movie.gotoAndStop(downFrame);
                _bone.applySkin(movie);
            }
        }
        /**
         * @inheritDoc
         */
        public function disabled():void
        {
            if (_bone && movie)
            {
                movie.gotoAndStop(disabledFrame);
                _bone.applySkin(movie);
            }
        }
    }
}
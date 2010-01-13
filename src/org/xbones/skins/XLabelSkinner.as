package org.xbones.skins
{
    import flash.display.FrameLabel;
    import flash.display.MovieClip;
    /**
     * Skinner use labels of a MovieCilp.
     * @author eidiot
     */
    public class XLabelSkinner extends XFrameSkinner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XLabelSkinner</code>.
         */
        public function XLabelSkinner(movie:MovieClip, upLabel:String = "up",
                                      overLabel:String = "over",
                                      downLabel:String = "down",
                                      disabledLabel:String = "disabled")
        {
            for each (var label:FrameLabel in movie.currentLabels)
            {
                switch (label.name)
                {
                    case upLabel:
                        upFrame = label.frame;
                        continue;
                    case overLabel:
                        overFrame = label.frame;
                        continue;
                    case downLabel:
                        downFrame = label.frame;
                        continue;
                    case disabledLabel:
                        disabledFrame = label.frame;
                        continue;
                }
            }
            super(movie, upFrame, overFrame, downFrame, disabledFrame);
        }
    }
}
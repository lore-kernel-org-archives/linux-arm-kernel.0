From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 3 Aug 2011 09:45:36 +0200
Subject: [PATCH v4 0/2] Add device tree support for i.mx51/53 boards
In-Reply-To: <20110802140610.GC20071@ponder.secretlab.ca>
References: <1312267943-25551-1-git-send-email-shawn.guo@linaro.org>
	<20110802140610.GC20071@ponder.secretlab.ca>
Message-ID: <20110803074536.GA17990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 03:06:10PM +0100, Grant Likely wrote:
> On Tue, Aug 02, 2011 at 02:52:21PM +0800, Shawn Guo wrote:
> > Changes since v3:
> >  * Fix machine_desc table for ARD matching
> >  * Turn the board setup that dt needs into callback
> > 
> > Changes since v2:
> >  * Drop iomuxc device tree support patch
> > 
> > Changes since v1:
> >  * Address comments on v1 given by Grant and Sascha
> >  * Add i.mx51 Babbage support
> > 
> > Shawn Guo (2):
> >       arm/mx5: add device tree support for imx53 boards
> >       arm/mx5: add device tree support for imx51 babbage
> 
> Looks good.
> 
> Sascha, assuming you're okay with it, I'd *really* like to ask Arnd to
> send this out to Linus immediately.  It may not be perfect, and we may
> change the device disable/enable policy, but it is useful enough that
> having it in mainline will help developers who want to start hacking
> on DT support.

ups, /me is missing on Cc.

Go ahead, I'm fine with it.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

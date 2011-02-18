From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 18 Feb 2011 17:36:23 +0800
Subject: [PATCH 2/2] ARM i.MX23/28: Add framebuffer device support
In-Reply-To: <20110218092650.GH24426@pengutronix.de>
References: <1297850199-1688-1-git-send-email-s.hauer@pengutronix.de>
	<1297850199-1688-3-git-send-email-s.hauer@pengutronix.de>
	<20110218061440.GA18085@S2100-06.ap.freescale.net>
	<20110218084625.GF24426@pengutronix.de>
	<20110218091717.GD18085@S2100-06.ap.freescale.net>
	<20110218092650.GH24426@pengutronix.de>
Message-ID: <20110218093622.GE18085@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 10:26:50AM +0100, Sascha Hauer wrote:
> On Fri, Feb 18, 2011 at 05:17:18PM +0800, Shawn Guo wrote:
> > > > I understand that "mxsfb" was picked up for the device name to
> > > > reflect the driver name.  But since this is the device under mach- mxs
> > > > folder, can we simply call it "fb" just like the way you name fb.h?
> > > > 
> > > > In this way, we have all mxs platform device naming schema aligned,
> > > > auart, duart, dma, fb, fec, flexcan, mmc ...
> > > 
> > > I see it the other way round. mach/fb.h is too generic, I would prefer
> > > mach/mxsfb.h to be able to add support for a different framebuffer
> > > later. So I better change fb.h to mxsfb.h.
> > > 
> > I'm fine with either way, but just wondering what kind of fb later
> > it is and its naming, relatively to mxsfs.
> 
> IPU...?
> 
AFAICT, this is something that never going to happen.

-- 
Regards,
Shawn

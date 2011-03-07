From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Mar 2011 15:45:04 +0800
Subject: A few mxsfb patches
In-Reply-To: <20110307072657.GF29521@pengutronix.de>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
	<20110307072657.GF29521@pengutronix.de>
Message-ID: <20110307074503.GA12291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2011 at 08:26:57AM +0100, Sascha Hauer wrote:
> Hi Shawn,
> 
Hi Sascha,

> On Sun, Mar 06, 2011 at 12:18:48AM +0800, Shawn Guo wrote:
> > The patches came from the work of adding framebuffer for mx28evk and
> > mx23evk boards.  They are all minor changes.
> > 
> >  [PATCH 1/3] video: mxsfb: smarten the code a little bit
> >  [PATCH 2/3] video: mxsfb: fix the incorrect error checking for alloc_pages_exact
> >  [PATCH 3/3] video: mxsfb: add DOTCLK polarity configuration support
> 
> As this driver is new, we can squash these patches into the original
> patch and add your ack to this one, if that's ok for you.
> 
No problem, as they are really some simple changes.

-- 
Regards,
Shawn

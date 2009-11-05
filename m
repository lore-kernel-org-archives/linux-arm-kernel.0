From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 5 Nov 2009 09:44:09 +0100
Subject: [PATCH] MXC: Add support for ULPI Viewports
In-Reply-To: <20091105083928.GN30179@pengutronix.de>
References: <20091030141635.GQ29442@buzzloop.caiaq.de>
	<20091105083928.GN30179@pengutronix.de>
Message-ID: <20091105084408.GG14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2009 at 09:39:28AM +0100, Sascha Hauer wrote:
> On Fri, Oct 30, 2009 at 03:16:35PM +0100, Daniel Mack wrote:
> > Below is a rebased version of the patch that adds ULPI viewports for
> > MX31 controllers. There was also a bug in the condition check for
> > ULPIVW_SS - && was used instead of &, a hertiage from the Freescale BSP,
> > which was copy'n pasted over and over again.
> > 
> > Daniel
> > 
> > 
> > From c523e69a3a3689e8108ff608cf2d8c919665baec Mon Sep 17 00:00:00 2001
> > From: Daniel Mack <daniel@caiaq.de>
> > Date: Thu, 25 Jun 2009 13:27:40 +0200
> > Subject: [PATCH] MXC: Add support for ULPI Viewports
> > 
> > The ARC USB OTG Core has support for accessing ULPI tranceivers
> > through so called ULPI viewports. Export a set of function for use with
> > the USB OTG framework.
> 
> Ok, added to mxc-master.

Did you take the latest one (which is not the one you quoted)?
There have been some updates to comments from Sergei Shtylyov.
See below.

Thanks,
Daniel

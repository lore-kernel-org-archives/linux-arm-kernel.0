From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 21 Dec 2010 21:26:36 +0800
Subject: [PATCH v8 00/15] ARM: mxs: Add initial support for MX23 and MX28
In-Reply-To: <20101220212955.GC14221@pengutronix.de>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
	<20101220212955.GC14221@pengutronix.de>
Message-ID: <20101221132635.GH16497@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Dec 20, 2010 at 10:29:55PM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Dec 20, 2010 at 10:57:41PM +0800, Shawn Guo wrote:
> > Changes for v8:
> >  - Reuse debug-pl01x.S as mxs DUART is just an amba-pl011
> So shouldn't "ARM: mxs: Dynamically allocate duart devices" create an
> amba-pl011 device?
> 
> >  - Remove extra space in iomux.c
> >  - Remove uncessary line breaker in mach-mx23evk.c
> > 
> >  [PATCH v8 05/15] ARM: mxs: Add low-level debug UART support
> >  [PATCH v8 08/15] ARM: mxs: Add iomux support
> >  [PATCH v8 13/15] ARM: mxs: Add initial mx23evk support
> 
> I was not yet able to boot a machine with an imx28 because of a missing
> rootfs (no flash, no ethernet driver) but up to there it looks good.
> 
> I suggest to let Sascha take the current series to get it into the next
> merge window and to be able to start patching based on something.  (Well
> unless Russell or Sascha still have objections.)
> 
> I already have a few (simple) patches; I will clean them up and send
> them in reply to this mail.
> 
> My next step is to look into the fec driver to make it work on mx28, so
> if anyone already has something and wants to stop me doing duplicate
> work, please tell me.
> 
I already have a workable fec driver to mount nfs.  If you do not mind,
I would continue the effort to send out a patch in the next a few days.

-- 
Regards,
Shawn

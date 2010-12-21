From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 21 Dec 2010 16:45:48 +0800
Subject: [PATCH v8 00/15] ARM: mxs: Add initial support for MX23 and MX28
In-Reply-To: <20101220212955.GC14221@pengutronix.de>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
	<20101220212955.GC14221@pengutronix.de>
Message-ID: <20101221084539.GE16497@freescale.com>
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
Yes, since doing this could save the duart driver in drivers/serial.
Will send a follow up patch for this soon.

-- 
Regards,
Shawn

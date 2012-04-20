From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 Apr 2012 11:48:05 +0200
Subject: [RFC PATCH 00/10 V3]  MXS: Add i.MX28 USB Host driver
In-Reply-To: <201204200413.56909.marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-1-git-send-email-marex@denx.de>
 <201204200413.56909.marex@denx.de>
Message-ID: <20120420094805.GS20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 04:13:56AM +0200, Marek Vasut wrote:
> > 
> > Cc: Chen Peter-B29397 <B29397@freescale.com>
> > Cc: Detlev Zundel <dzu@denx.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Li Frank-B20596 <B20596@freescale.com>
> > Cc: Lin Tony-B19295 <B19295@freescale.com>
> > Cc: Linux USB <linux-usb@vger.kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > Cc: Subodh Nijsure <snijsure@grid-net.com>
> > Cc: Tony Lin <tony.lin@freescale.com>
> > Cc: Wolfgang Denk <wd@denx.de>
> 
> btw /wrt USB Gadget etc -- how does the drivers/usb/gadget/fsl_udc_core.c and 
> drivers/usb/gadget/ci13xxx_* fit into the big picture? We're gonna use the 
> ci13xxx stuff for Gadget on mx28, correct? Then how does fsl_udc_core.c fit in?

>From what I have been told by a collegue the ci13xxx driver works
better, and from what I have seen the code looks better. So I think mxs
should use it. i.MX can then use it later aswell. We won't need the
fsl_udc_core driver anymore then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

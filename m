From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 21 Jan 2013 19:23:59 +0100
Subject: IMX not ready for multiplatform?
In-Reply-To: <20130121133835.GI23505@n2100.arm.linux.org.uk>
References: <20130121133835.GI23505@n2100.arm.linux.org.uk>
Message-ID: <20130121182359.GC1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 01:38:35PM +0000, Russell King - ARM Linux wrote:
> drivers/usb/gadget/imx_udc.c:39:27: fatal error: mach/hardware.h: No such file or directory
> drivers/usb/gadget/fsl_mxc_udc.c:21:27: fatal error: mach/hardware.h: No such file or directory
> 
> is rather suggestive in my OMAP4 randconfig build.
> 
> Might like to have this fixed before the next merge window, so we don't
> cause regressions.

This is being worked on by Peter Chen (CCed), see

[PATCH v7 0/3] Fix the Build error for fsl_mxc_udc.c

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

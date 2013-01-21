From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 13:38:35 +0000
Subject: IMX not ready for multiplatform?
Message-ID: <20130121133835.GI23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/usb/gadget/imx_udc.c:39:27: fatal error: mach/hardware.h: No such file or directory
drivers/usb/gadget/fsl_mxc_udc.c:21:27: fatal error: mach/hardware.h: No such file or directory

is rather suggestive in my OMAP4 randconfig build.

Might like to have this fixed before the next merge window, so we don't
cause regressions.

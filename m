From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Sep 2012 08:13:13 -0700
Subject: [PATCH] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
In-Reply-To: <1348815748-30072-1-git-send-email-balbi@ti.com>
References: <20120927202615.GS4840@atomide.com>
 <1348815748-30072-1-git-send-email-balbi@ti.com>
Message-ID: <20120928151051.GC4840@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120928 00:08]:
> In order to make single zImage work for ARM architecture,
> we need to make sure we don't depend on private headers.
> 
> Move USB platform_data to <linux/platform_data/omap-usb.h>

The new standard seems to be subsystem-soc.h, so usb-omap.h :)

> and keep only internal functions in <plat/usb.h>.

Can the remaining parts be in #include "usb.h" in mach-omap2?

Regards,

Tony

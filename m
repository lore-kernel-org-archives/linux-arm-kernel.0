From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Oct 2012 13:34:04 -0700
Subject: [PATCH v2] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
In-Reply-To: <1350488838-6289-1-git-send-email-balbi@ti.com>
References: <20121016230040.GP15569@atomide.com>
 <1350488838-6289-1-git-send-email-balbi@ti.com>
Message-ID: <20121017203404.GY15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [121017 08:54]:
> In order to make single zImage work for ARM architecture,
> we need to make sure we don't depend on private headers.
> 
> Move USB platform_data to <linux/platform_data/omap-usb.h>
> and keep only internal functions in <plat/usb.h>.

Thanks, looks like I can't make this apply against v3.7-rc1:

patching file arch/arm/plat-omap/include/plat/usb.h
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 26.
Hunk #3 FAILED at 44.
Hunk #4 FAILED at 65.
Hunk #5 FAILED at 81.
Hunk #6 succeeded at 28 with fuzz 2 (offset -128 lines).
5 out of 6 hunks FAILED -- rejects in file arch/arm/plat-omap/include/plat/usb.h

Can you please check it?

Regards,

Tony

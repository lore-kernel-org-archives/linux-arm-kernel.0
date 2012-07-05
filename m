From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jul 2012 07:33:34 -0700
Subject: [PATCH v1 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <1341490136-25901-7-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
 <1341490136-25901-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120705143333.GE1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120705 05:13]:
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -10,9 +10,7 @@ obj-n :=
>  obj-  :=
>  
>  # omap_device support (OMAP2+ only at the moment)
> -obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
> -obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> -obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
> +obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
>  
>  obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
>  obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o

FYI, this we already have as commit b4cb410d in devel-am33xx-part2.
I can merge first few patches in devel-am33xx-part2 branch into
cleanup-part2 so this part can be just left out.

Regards,

Tony

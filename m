From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Feb 2015 10:02:53 -0800
Subject: [PATCH 0/2] ARM: omap2plus_defconfig: Fix SATA and NAND for
 v4.0-rc
In-Reply-To: <1424704717-29728-1-git-send-email-rogerq@ti.com>
References: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Message-ID: <20150224180253.GF11056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [150223 07:22]:
> Hi,
> 
> These changes fix SATA boot and NAND for OMAP based boards.
> 
> I must also point out that basic SATA operation is also
> broken when TI_PIPE3 driver is built as a module.
> I will be investigating that on lower priority.

OK applying into omap-for-v4.0/fixes. At some point we're going
to make everything use loadable modules and initramfs so best
to make sure things work as loadable modules.

Regards,

Tony
 
> Roger Quadros (2):
>   ARM: omap2plus_defconfig: Enable OMAP NAND BCH driver
>   ARM: omap2plus_defconfig: Fix SATA boot
> 
>  arch/arm/configs/omap2plus_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> -- 
> 2.1.0
> 

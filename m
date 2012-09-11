From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 11 Sep 2012 06:55:57 +0000
Subject: [PATCH] ARM: OMAP2+: Makefile.boot: Add am335x evm and bone
 targets
In-Reply-To: <1346435674-6207-1-git-send-email-hvaibhav@ti.com>
References: <1346435674-6207-1-git-send-email-hvaibhav@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB0764@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 23:24:34, Hiremath, Vaibhav wrote:
> This adds am335x-evm and am335x-bone dtb targets to
> 'make dtbs', just like other platforms.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile.boot |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
> index 6cf1c2d..1136072 100644
> --- a/arch/arm/mach-omap2/Makefile.boot
> +++ b/arch/arm/mach-omap2/Makefile.boot
> @@ -7,3 +7,4 @@ dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-evm.dtb
>  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
>  dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
>  dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
> +dtb-$(CONFIG_SOC_AM33XX)	+= am335x-evm.dtb am335x-bone.dtb

Tony,

Gentle reminder on this patch !!!

Thanks,
Vaibhav

> -- 
> 1.7.0.4
> 
> 

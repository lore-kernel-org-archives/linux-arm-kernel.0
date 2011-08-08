From: santosh.shilimkar@ti.com (Santosh)
Date: Mon, 08 Aug 2011 16:39:32 +0530
Subject: OMAP3 kernels fail to build
In-Reply-To: <20110808110056.GA15134@n2100.arm.linux.org.uk>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
Message-ID: <4E3FC3EC.2010909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Felipe,

On Monday 08 August 2011 04:30 PM, Russell King - ARM Linux wrote:
> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
>
> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'
>
I thought below patch was suppose to fix it.
https://patchwork.kernel.org/patch/963462/


Regards
Santosh

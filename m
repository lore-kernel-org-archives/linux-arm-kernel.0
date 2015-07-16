From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Jul 2015 00:56:27 -0700
Subject: [PATCH 0/4] ARM: omap2plus_defconfig updates
In-Reply-To: <cover.1436368740.git.nsekhar@ti.com>
References: <cover.1436368740.git.nsekhar@ti.com>
Message-ID: <20150716075627.GJ17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sekhar Nori <nsekhar@ti.com> [150708 08:30]:
> Hi Tony,
> 
> Here are some defconfig updates for commonly
> used drivers on platforms supported by
> omap2plus_defconfig.
> 
> Applies to v4.2-rc1
> 
> Thanks,
> Sekhar
> 
> Sekhar Nori (4):
>   ARM: omap2plus_defconfig: enable support for TI ADC
>   ARM: omap2plus_defconfig: enable support for TI touchscreen
>   ARM: omap2plus_defconfig: enable support for TI CPTS
>   ARM: omap2plus_defconfig: enable support for M25P80 SPI NOR
> 
>  arch/arm/configs/omap2plus_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)

Applying all into omap-for-v4.3/defconfig thanks.

Tony

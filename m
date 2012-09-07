From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 7 Sep 2012 07:19:17 +0200
Subject: [PATCH 07/12] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <50495DB9.5030008@wwwdotorg.org>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-8-git-send-email-robherring2@gmail.com>
 <20120907022711.GE26709@S2101-09.ap.freescale.net>
 <50495DB9.5030008@wwwdotorg.org>
Message-ID: <20120907051917.GD10582@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > PS. A little heads-up: if this lands on 3.7, there will be conflict
> > on arch/arm/mach-mxs/Makefile.boot which gets new entries in this
> > cycle.
> 
> The same is true of Tegra:
> 
> -dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu.dtb
> +dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu-a02.dtb
> +dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu-a04.dtb

Ditto kirkwood and mvebu. And Dove might also gain DT support,
resulting in new entries in its Makefile.boot.

	Andrew

From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Aug 2017 09:33:56 -0700
Subject: [PATCH 00/12] ARM: dts: Add iodelay data for MMC
In-Reply-To: <20170616115439.8508-1-kishon@ti.com>
References: <20170616115439.8508-1-kishon@ti.com>
Message-ID: <20170810163356.GF8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170616 04:54]:
> This is the second part of the series originally sent as
> part of [1] with one important modification.
> 
> Now PINCTRL_TI_IODELAY will be enabled for SOC_DRA7XX
> (in mach-omap2/Kconfig) so that omap2plus_defconfig or
> multi_v7_defconfig don't have to be modified.
> 
> This series only adds data and it won't be used until
> the next series which adds UHS support to omap_hsmmc driver.

Applying these finally into omap-for-v4.14/dt thanks.

Tony

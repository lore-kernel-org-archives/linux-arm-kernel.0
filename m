From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Mar 2017 14:00:05 -0700
Subject: [PATCH v2 0/4] ARM: dm8168-evm: add SATA support
In-Reply-To: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
References: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20170323210003.GR10760@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bartosz Golaszewski <bgolaszewski@baylibre.com> [170314 04:16]:
> This series implements support for the on-board SATA controller
> on the dm8168-evm board.
> 
> The first patch adds the clock domain and hwmod entries for the
> SATA module.
> 
> The second patch models the external reference clock used by SATA.
> 
> The third adds the SATA node to the SoC's device tree.
> 
> The fourth enables the SATA driver by default in omap2plus_defconfig.
> 
> Tested together with the series implementing the driver for
> ahci-dm816 on a DM8168-EVM board.
> 
> v1 -> v2:
>   PATCH 1/4:
>     - removed the unused define from cm81xx.h
>   PATCH 3/4:
>     - fixed the size of the mapped register region
> 
> Bartosz Golaszewski (3):
>   ARM: dts: dm8168-evm: add the external reference clock for SATA
>   ARM: dts: dm8168-evm: add SATA node
>   ARM: omap2plus_defconfig: enable ahci-dm816 module
> 
> Kevin Hilman (1):
>   ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA

Applying all for for v4.12 into soc, dts-v2 and defconfig
branches.

Thanks,

Tony

From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Jul 2015 20:57:33 +0530
Subject: [PATCH 0/4] ARM: omap2plus_defconfig updates
Message-ID: <cover.1436368740.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here are some defconfig updates for commonly
used drivers on platforms supported by
omap2plus_defconfig.

Applies to v4.2-rc1

Thanks,
Sekhar

Sekhar Nori (4):
  ARM: omap2plus_defconfig: enable support for TI ADC
  ARM: omap2plus_defconfig: enable support for TI touchscreen
  ARM: omap2plus_defconfig: enable support for TI CPTS
  ARM: omap2plus_defconfig: enable support for M25P80 SPI NOR

 arch/arm/configs/omap2plus_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.4.4.408.g16da57c

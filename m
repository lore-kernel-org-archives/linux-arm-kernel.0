From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 28 Apr 2015 13:59:40 +0300
Subject: [PATCH 0/4] ARM: digicolor: dt and config updates
Message-ID: <cover.1430217994.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables a couple of digicolor SoC devices for which drives were
added during the v4.1 cycle. Also, add a MAINTAINERS entry for digicolor, and
enabled the platform in multi_v7_defconfig.

Based on v4.1-rc1.

Baruch Siach (4):
  ARM: digicolor: enable CX92755 on-chip RTC device
  ARM: digicolor: add i2c master controller support
  MAINTAINERS: add Conexant Digicolor machines entry
  ARM: multi_v7_defconfig: enable Conexant Digicolor platform

 MAINTAINERS                           |  6 ++++++
 arch/arm/boot/dts/cx92755.dtsi        | 17 +++++++++++++++++
 arch/arm/boot/dts/cx92755_equinox.dts |  4 ++++
 arch/arm/configs/multi_v7_defconfig   |  5 +++++
 4 files changed, 32 insertions(+)

-- 
2.1.4

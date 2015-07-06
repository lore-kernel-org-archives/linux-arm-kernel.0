From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  6 Jul 2015 14:41:42 +0300
Subject: [PATCH 0/4] ARM: digicolor: misc updates for 4.3
Message-ID: <cover.1436182214.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the following updates for Conexant Digicolor machines:

   * Enable the watchdog driver that was added during the 4.2 merge window, 
     both in .dtsi and in multi_v7_defconfig

   * Use the standard stdout-path property in the chosen node to configure the 
     console

   * Make .dts/.dtsi files to the Digicolor MAINTAINERS entry

Based on v4.2-rc1.

Baruch Siach (4):
  ARM: digicolor: enable watchdog device
  ARM: multi_v7_defconfig: enable Conexant Digicolor watchdog
  ARM: digicolor: dts: use stdout-path for console configuration
  MAINTAINERS: digicolor: add dts files

 MAINTAINERS                           | 1 +
 arch/arm/boot/dts/cx92755.dtsi        | 7 +++++++
 arch/arm/boot/dts/cx92755_equinox.dts | 3 +--
 arch/arm/configs/multi_v7_defconfig   | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.1.4

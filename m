From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Fri, 28 Nov 2014 14:29:46 +0800
Subject: [PATCH v3 0/2] ARM: hip04: add GPIO support
Message-ID: <1417156188-500-1-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add the support for the GPIOs of Hisilicon Soc hip04. Hip04 uses
synopsis' GPIO IP, and we use the dwapb GPIO driver here. This series add the
corresponding dts.

Change in v3:
- Move CONFIG_GPIO_DWAPB to hisi_defconfig
- Add CONFIG_GPIOLIB, CONFIG_GPIO_SYSFS in hisi_defconfig
Change in v2:
- Add select GPIO_DWAPB in arch/arm/mach-hisi/Kconfig

Zhou Wang (2):
  ARM: hip04: set ARCH_NR_GPIO to 128
  ARM: dts: hip04: add GPIO pieces

 arch/arm/Kconfig                |    1 +
 arch/arm/boot/dts/hip04.dtsi    |   75 +++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hisi_defconfig |    3 ++
 3 files changed, 79 insertions(+)

-- 
1.7.9.5

From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Wed, 26 Nov 2014 14:43:30 +0800
Subject: [PATCH v2 0/2] ARM: hip04: add GPIO support
Message-ID: <1416984212-619-1-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add the support for the GPIOs of Hisilicon Soc hip04. Hip04 uses
synopsis' GPIO IP, and we use the dwapb GPIO driver here. This series add the
corresponding dts.

Change in v2:
- Add select GPIO_DWAPB in arch/arm/mach-hisi/Kconfig

Zhou Wang (2):
  ARM: hip04: set ARCH_NR_GPIO to 128
  ARM: dts: hip04: add GPIO pieces

 arch/arm/Kconfig             |    1 +
 arch/arm/boot/dts/hip04.dtsi |   75 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig   |    1 +
 3 files changed, 77 insertions(+)

-- 
1.7.9.5

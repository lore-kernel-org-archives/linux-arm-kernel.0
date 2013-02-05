From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 14:04:15 +0800
Subject: [GIT PULL] mxs device tree changes for 3.9
Message-ID: <20130205060413.GE10807@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.9

for you to fetch changes up to 0943b96058c4262b4e4cd05398f42e8730d5ee08:

  ARM: mxs: dts: Add rotary encoder to the CFA-10049 (2013-01-31 22:31:19 +0800)

----------------------------------------------------------------
mxs device tree changes for 3.9

 - Mostly cfa100xx related device tree source updates

----------------------------------------------------------------
Marek Vasut (1):
      ARM: mxs: Enable touchscreen on m28evk

Maxime Ripard (7):
      ARM: dts: cfa10049: Add PCA9555 GPIO expander to the device tree
      ARM: mxs: dt: Add Crystalfontz CFA-10037 device tree support
      ARM: dts: cfa10049: Change the SPI3 bus to spi-gpio
      ARM: dts: mxs: Add muxing options for the third PWM
      ARM: dts: mxs: Add the LCD to the 10049 board
      ARM: mxs: dts: Add gpio-keys for the rotary to the CFA-10049
      ARM: mxs: dts: Add rotary encoder to the CFA-10049

 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/boot/dts/imx28-cfa10037.dts |   77 ++++++++++++
 arch/arm/boot/dts/imx28-cfa10049.dts |  214 +++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/imx28-m28evk.dts   |    1 +
 arch/arm/boot/dts/imx28.dtsi         |   10 ++
 arch/arm/mach-mxs/mach-mxs.c         |   30 +++++
 6 files changed, 302 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-cfa10037.dts

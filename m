From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 15:54:06 +0800
Subject: [GIT PULL] imx device tree changes for 3.6 (part 2)
Message-ID: <20120712075405.GM6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is the second (last) batch of imx device tree changes for 3.6.
Please pull.

Regards,
Shawn

The following changes since commit 77ac32ad2b03baa7638aadda1650200287ca6f5d:

  ARM: imx6q: add clocks for gpmi-nand (2012-07-03 11:39:57 +0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt-for-3.6

Hui Wang (1):
      ARM: dts: imx6q-sabrelite: add ecspi1 pinctrl support

Otavio Salvador (1):
      ARM: imx6q: ensure ANATOP controller is available

Richard Zhao (4):
      ARM: imx6q: add usb controller clock lookups
      ARM: imx6q: add usbphy clocks
      ARM: imx6q: disable usb charger detector
      ARM: dts: imx6q-sabrelite: add usb devices

Shawn Guo (2):
      bindings: update imx and mxs #gpio-cells
      ARM: dts: imx: update #interrupt-cells for gpio nodes

 .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |   14 ++++-
 .../devicetree/bindings/gpio/gpio-mxs.txt          |    5 +-
 arch/arm/boot/dts/imx27.dtsi                       |   12 ++--
 arch/arm/boot/dts/imx51.dtsi                       |    8 ++--
 arch/arm/boot/dts/imx53.dtsi                       |   14 +++---
 arch/arm/boot/dts/imx6q-sabrelite.dts              |   33 +++++++++++
 arch/arm/boot/dts/imx6q.dtsi                       |   58 +++++++++++++++++---
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/clk-imx6q.c                      |   11 ++++-
 arch/arm/mach-imx/mach-imx6q.c                     |   41 ++++++++++++++
 10 files changed, 166 insertions(+), 31 deletions(-)

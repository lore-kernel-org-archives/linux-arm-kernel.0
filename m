From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Mon, 30 Jun 2014 15:28:04 +0200
Subject: [PATCH 0/5] some additions for the edmqmx6 board
Message-ID: <cover.1404132504.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please add this patches to your imx-tree.

Is it possible to add the first patch to your current imx-fixes branch? The
boards give some warnings of unresolved depencies like "gpio-leds: Driver
leds-gpio requests probe deferral" . With these patches it is gone.


Thank you and bye,
Silvio



Silvio Fricke (5):
  ARM: imx_v6_v7_defconfig: Enable STMPE gpio support
  ARM: dts: imx6: edmqmx6: Add PCIe support
  ARM: dts: imx6: edmqmx6: Add two other i2c busses
  ARM: dts: imx6: edmqmx6: Add can bus
  ARM: imx_v6_v7_defconfig: Enable flexcan driver for can support

 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 54 +++++++++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |  3 ++
 2 files changed, 57 insertions(+)

-- 
2.0.0

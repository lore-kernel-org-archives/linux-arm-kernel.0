From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Tue,  1 Jul 2014 13:08:57 +0200
Subject: [PATCH v2 0/5] some additions for the edmqmx6 board
In-Reply-To: <cover.1404132504.git.silvio.fricke@gmail.com>
References: <cover.1404132504.git.silvio.fricke@gmail.com>
Message-ID: <cover.1404212584.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please add this patches to your imx-tree.

v2:
* add changes suggested by Shawn Guo
  * iomux config changed for can and pcie-reset gpio
  * flexcan not as module

Thank you and bye,
Silvio


Silvio Fricke (5):
  ARM: imx_v6_v7_defconfig: Enable STMPE gpio support
  ARM: dts: imx6: edmqmx6: Add PCIe support
  ARM: dts: imx6: edmqmx6: Add two other i2c buses
  ARM: dts: imx6: edmqmx6: Add can bus
  ARM: imx_v6_v7_defconfig: Enable flexcan driver for can support

 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 54 +++++++++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig    |  3 ++
 2 files changed, 57 insertions(+)

-- 
2.0.0

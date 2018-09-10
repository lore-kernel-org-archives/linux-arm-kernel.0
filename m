From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Mon, 10 Sep 2018 11:37:51 +0200
Subject: [PATCH v3] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
Message-ID: <1536572272-18590-1-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device tree for the ConnectCore 6UL SBC Pro board, based on
the ConnectCore 6UL SOM.

Changes since v2 [2]:

* Removed redundant clocks from pwm nodes
* Use real iomux pad values
* Spelling change in regulator-usb-otg1 node name

Changes since v1 [1]:

* Removed unused pinctrl nodes
* Replace undocumented vendor BSP node by using GPIO hogs
* Formatting changes:
        * Change node names to use dashes instead of underscores

[1] https://lore.kernel.org/lkml/1534936719-13770-2-git-send-email-alex.gonzalez at digi.com/
[2] https://lore.kernel.org/lkml/1536074909-8654-1-git-send-email-alex.gonzalez at digi.com/

Alex Gonzalez (1):
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 390 ++++++++++++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts

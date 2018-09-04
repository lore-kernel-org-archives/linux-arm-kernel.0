From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Tue, 4 Sep 2018 17:28:28 +0200
Subject: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
Message-ID: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device tree for the ConnectCore 6UL SBC Pro board, based
on the ConnectCore 6UL SOM.

Changes since v1 [1]:

* Removed unused pinctrl nodes
* Replace undocumented vendor BSP node by using GPIO hogs
* Formatting changes:
        * Change node names to use dashes instead of underscores

[1] https://lore.kernel.org/lkml/1534936719-13770-2-git-send-email-alex.gonzalez at digi.com/

Alex Gonzalez (1):
  ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 394 ++++++++++++++++++++++++++++
 2 files changed, 395 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts

From: c.hemp@phytec.de (Christian Hemp)
Date: Tue, 11 Jun 2013 19:48:20 +0200
Subject: [PATCH v2 0/2] Add Phytec imx6q module and carrier board
Message-ID: <1370972902-23934-1-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn

This patchset adds basic support for Phytec's phyFLEX-i.MX6 kit.

It's based on git repo from Shwan Guo branche imx/dt

v2;
 - Remove not needed pin from ethernet group.
 - Cleaned up name for board and module.
 - Set SoC before family name.
 - Split board and module in separated files.

Christian

Christian Hemp (2):
  ARM: dts: imx6q: Add pinctrl for usdhc2 and enet
  ARM: dts: Phytec imx6q pfla02 and pbab01 support

 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |   34 +++++++++++++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   75 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi               |   32 ++++++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-pbab01.dts
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi

-- 
1.7.9.5

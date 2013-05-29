From: c.hemp@phytec.de (Christian Hemp)
Date: Wed, 29 May 2013 23:06:47 +0200
Subject: [PATCH 0/2] Add Phytec phyFLEX-i.MX6 board
Message-ID: <1369861609-30408-1-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds basic support for Phytec's phyFLEX-i.MX6.

It's based on git repo from Shwan Guo branche imx/dt

Christian Hemp (2):
  ARM: dts: imx6q: Add pinctrl for usdhc2 and enet
  ARM: dts: Phytec phyFLEX-i.MX6 support

 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/imx6q-phytec-phyflex.dts |   76 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi               |   33 ++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-phyflex.dts

-- 
1.7.9.5

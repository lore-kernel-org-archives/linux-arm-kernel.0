From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 22 Oct 2013 21:51:24 -0700
Subject: [PATCH 0/4]: ARM: dts: Add Gateworks Ventana Support
Message-ID: <1382503888-3962-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gateworks Ventana product family consists of several baseboard designs
based on the Freescale i.MX6 family of processors.

Tim Harvey (4):
  ARM: dts: added several new imx-pinmux groups
  ARM: dts: add Gateworks Ventana support
  ARM: dts: disable flexcan by default
  imx: add PCI fixup for PEX860X on Gateworks board

 arch/arm/boot/dts/Makefile            |    9 +
 arch/arm/boot/dts/imx6dl-gw51xx.dts   |   19 ++
 arch/arm/boot/dts/imx6dl-gw52xx.dts   |   19 ++
 arch/arm/boot/dts/imx6dl-gw53xx.dts   |   19 ++
 arch/arm/boot/dts/imx6dl-gw54xx.dts   |   19 ++
 arch/arm/boot/dts/imx6q-gw51xx.dts    |   19 ++
 arch/arm/boot/dts/imx6q-gw52xx.dts    |   23 ++
 arch/arm/boot/dts/imx6q-gw53xx.dts    |   23 ++
 arch/arm/boot/dts/imx6q-gw5400-a.dts  |  443 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-gw54xx.dts    |   23 ++
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi |  272 ++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi |  373 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi |  429 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi |  457 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi        |   62 +++++
 arch/arm/mach-imx/mach-imx6q.c        |   33 +++
 16 files changed, 2242 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-gw51xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw52xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw53xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw54xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw51xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw52xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw53xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5400-a.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw54xx.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi

-- 
1.7.9.5

From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:12:50 -0700
Subject: [PATCH V2 00/13] Update Sabre Lite
Message-ID: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series updates the Sabre Lite board
and then bases a new board Nitrogen6x on it.

Eric Nelson created a web page to show the
differences between the two boards.
http://boundarydevices.com/differences-sabre-lite-nitrogen6x


Troy Kisky (13):
  ARM: dts: imx6qdl-sabrelite: move pcie to imx6qdl-sabrelite.dtsi
  ARM: dts: imx6qdl-sabrelite: move USDHC4 CD to pinctrl_usdhc4
  ARM: dts: imx6qdl-sabrelite: move USDHC3 CD/WP to pinctrl_usdhc3
  ARM: dts: imx6qdl-sabrelite: move spi-nor CS to pinctrl_ecspi1
  ARM: dts: imx6qdl-sabrelite: move usbotg power enable to
    pinctrl_usbotg
  ARM: dts: imx6qdl-sabrelite: move phy reset to pinctrl_enet
  ARM: dts: imx6qdl-sabrelite: explicitly set pad for SGTL5000 sys_mclk
  ARM: dts: imx6qdl-sabrelite: add gpio-keys
  ARM: dts: imx6qdl-sabrelite: add pwms for backlights
  ARM: dts: imx6qdl-sabrelite: add skews for Micrel phy
  ARM: dts: imx6qdl-sabrelite: fix ENET group
  ARM: dts: imx6qdl-sabrelite: Add over-current pin to usbotg
  ARM: dts: imx: add nitrogen6x board

 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts   |  22 ++
 arch/arm/boot/dts/imx6q-nitrogen6x.dts    |  26 ++
 arch/arm/boot/dts/imx6q-sabrelite.dts     |   4 -
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 385 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 176 +++++++++++++-
 6 files changed, 599 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-nitrogen6x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi

-- 
1.8.1.2

From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 12 Dec 2013 18:49:04 -0700
Subject: [PATCH V1 00/11] Update Sabre Lite
Message-ID: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series updates the Sabre Lite board 
and then bases a new board Nitrogen6x on it.

Eric Nelson created a web page to show the
differences between the two boards.
http://boundarydevices.com/differences-sabre-lite-nitrogen6x


Troy Kisky (11):
  ARM: dts: imx: sabrelite: add dualLite support
  ARM: dts: imx6qdl-sabrelite: Add uart1 support
  ARM: dts: imx6qdl-sabrelite: remove usdhc4 wp-gpio
  ARM: dts: imx6qdl-sabrelite: add comments for pinctrl_hog
  ARM: dts: imx6qdl-sabrelite: specify pad settings
  ARM: dts: imx6qdl-sabrelite: add gpio-keys
  ARM: dts: imx6qdl-sabrelite: add pwms for backlights
  ARM: dts: imx6qdl-sabrelite: add skews for Micrel phy
  ARM: dts: imx6qdl-sabrelite: fix ENET group
  ARM: dts: imx6qdl-sabrelite: Add over-current pin to usbotg
  ARM: dts: imx: add nitrogen6x board

 arch/arm/boot/dts/Makefile                |   3 +
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts   |  22 ++
 arch/arm/boot/dts/imx6dl-sabrelite.dts    |  20 ++
 arch/arm/boot/dts/imx6q-nitrogen6x.dts    |  26 +++
 arch/arm/boot/dts/imx6q-sabrelite.dts     | 214 +----------------
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 365 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 366 ++++++++++++++++++++++++++++++
 7 files changed, 803 insertions(+), 213 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-nitrogen6x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-sabrelite.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi

-- 
1.8.1.2

From: jagan@openedev.com (Jagan Teki)
Date: Wed, 22 Mar 2017 23:18:05 +0530
Subject: [PATCH 00/12] ARM: dts: i.MX6: Add lcdif/sound nodes on Engicam SOMs
Message-ID: <1490204897-14525-1-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

This patchset, add support for backlight, lcdif, touchscreen,
sound card and related codec and can nodes all Engicam SOM's
which are supporting mainline as of now.

Jagan Teki (12):
  ARM: dts: imx6ul-geam: Add backlight support for lcdif
  ARM: dts: imx6ul-isiot: Add backlight support for lcdif
  ARM: dts: imx6ul-isiot: Add imx6ul-isiot-common.dtsi
  ARM: dts: imx6ul-isiot: Add i2c nodes
  ARM: dts: imx6ul-isiot-common: Add touchscreen node
  ARM: dts: imx6ul-[geam|isiot]: Add sai2 node
  ARM: dts: imx6ul-isiot: Add Sound card with codec node
  ARM: dts: imx6ul-geam: Add Sound card with codec node
  ARM: dts: imx6qdl-icore: Add Sound card with codec node
  ARM: dts: imx6dl-icore: Add LVDS support
  ARM: dts: imx6dl-icore: Add touchscreen node
  ARM: dts: imx6qdl-icore-rqs: Add CAN nodes

 arch/arm/boot/dts/imx6dl-icore-rqs.dts     |   8 ++
 arch/arm/boot/dts/imx6dl-icore.dts         |  45 +++++++++
 arch/arm/boot/dts/imx6q-icore-ofcap10.dts  |  11 +++
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts  |  11 +++
 arch/arm/boot/dts/imx6q-icore-rqs.dts      |   8 ++
 arch/arm/boot/dts/imx6q-icore.dts          |  11 +++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi   |  26 +++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi       |  37 +++++++
 arch/arm/boot/dts/imx6ul-geam-kit.dts      |  13 +++
 arch/arm/boot/dts/imx6ul-geam.dtsi         |  57 +++++++++++
 arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 152 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts    |   1 +
 arch/arm/boot/dts/imx6ul-isiot-nand.dts    |   1 +
 arch/arm/boot/dts/imx6ul-isiot.dtsi        | 103 +++++++++++++++++++
 14 files changed, 484 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-common.dtsi

-- 
1.9.1

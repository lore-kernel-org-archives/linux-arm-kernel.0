From: jagan@openedev.com (Jagan Teki)
Date: Thu,  6 Apr 2017 23:32:06 +0530
Subject: [PATCH v3 0/9] ARM: dts: i.MX6: Add lcdif/sound nodes on Engicam SOMs
Message-ID: <1491501735-1649-1-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

This patchset, add support for LVDS, touchscreen, sound card and related codec
and can nodes all Engicam SOM's which are supporting mainline as of now.

Jagan Teki (9):
  ARM: dts: imx6ul-isiot: Add Sound card with codec node
  ARM: dts: imx6ul-geam: Add Sound card with codec node
  ARM: dts: imx6qdl-icore: Add Sound card with codec node
  ARM: dts: imx6dl-icore-rqs: Add sgtl5000 codec node
  ARM: dts: imx6qdl-icore-rqs: Replace to use simple-audio-card
  ARM: dts: imx6dl-icore: Add LVDS support
  ARM: dts: imx6dl-icore: Add touchscreen node
  ARM: dts: imx6qdl-icore-rqs: Add CAN nodes
  ARM: dts: imx6ul-isiot: Add FEC node support

 arch/arm/boot/dts/imx6dl-icore-rqs.dts     | 19 ++++++++
 arch/arm/boot/dts/imx6dl-icore.dts         | 45 +++++++++++++++++
 arch/arm/boot/dts/imx6q-icore-ofcap10.dts  | 11 +++++
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts  | 11 +++++
 arch/arm/boot/dts/imx6q-icore-rqs.dts      | 21 ++++----
 arch/arm/boot/dts/imx6q-icore.dts          | 11 +++++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi   | 51 ++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi       | 48 +++++++++++++++++++
 arch/arm/boot/dts/imx6ul-geam-kit.dts      | 12 +++++
 arch/arm/boot/dts/imx6ul-geam.dtsi         | 26 ++++++++++
 arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 10 ++++
 arch/arm/boot/dts/imx6ul-isiot.dtsi        | 77 ++++++++++++++++++++++++++++++
 12 files changed, 329 insertions(+), 13 deletions(-)

-- 
1.9.1

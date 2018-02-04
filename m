From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sun,  4 Feb 2018 23:19:24 +0530
Subject: [PATCH v3 0/7] ARM: dts: imx6q: engicam LVDS panel changes
Message-ID: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series adda LVDS panel attributes on panel drivers instead of defining
them in dts nodes, and also added new icorem6 engicam boards.

Jagan Teki (7):
  drm/panel: simple: add support for Ampire AM-800480AYTZQW-00H
  ARM: dts: imx6q-icore: Switch LVDS timings from panel-simple
  ARM: dts: imx6dl-icore: Add LVDS node
  drm/panel: simple: Add support for KEO TX31D200VM0BAA
  ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings from panel-simple
  ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 7
    initial support
  ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit
    support

 .../display/panel/ampire,am-800480aytzqw-00h.txt   | 25 +++++++++
 .../bindings/display/panel/koe,tx31d200vm0baa.txt  | 25 +++++++++
 arch/arm/boot/dts/Makefile                         |  2 +
 arch/arm/boot/dts/imx6dl-icore.dts                 | 28 ++++++++++
 arch/arm/boot/dts/imx6q-icore-mipi.dts             | 25 +++++++++
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts          | 31 ++++++-----
 arch/arm/boot/dts/imx6q-icore-ofcap7.dts           | 65 ++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-icore.dts                  | 31 ++++++-----
 arch/arm/boot/dts/imx6qdl-icore.dtsi               | 25 ++++++++-
 drivers/gpu/drm/panel/panel-simple.c               | 54 ++++++++++++++++++
 10 files changed, 282 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
 create mode 100644 arch/arm/boot/dts/imx6q-icore-mipi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap7.dts

-- 
2.7.4

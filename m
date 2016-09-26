From: jteki@openedev.com (Jagan Teki)
Date: Tue, 27 Sep 2016 00:53:07 +0530
Subject: [PATCH v6 0/6] ARM: dts: imx6q: Add Engicam i.CoreM6 dts
Message-ID: <1474917787-29030-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is series add dts support for Engicam I.Core M6 qdl modules on 
top of */shawnguo/linux.git for-next.

Jagan Teki (6):
  of: Add vendor prefix for Engicam s.r.l company
  ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual initial support
  ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo initial support
  ARM: dts: imx6qdl-icore: Add usbhost support
  ARM: dts: imx6qdl-icore: Add usbotg support
  ARM: dts: imx6qdl-icore: Add FEC support

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-icore.dts                 |  59 +++++
 arch/arm/boot/dts/imx6q-icore.dts                  |  59 +++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi               | 271 +++++++++++++++++++++
 5 files changed, 392 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore.dtsi

-- 
2.7.4

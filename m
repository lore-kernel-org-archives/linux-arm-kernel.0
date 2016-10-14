From: jteki@openedev.com (Jagan Teki)
Date: Fri, 14 Oct 2016 14:57:18 +0530
Subject: [PATCH v7 0/5] ARM: dts: imx6q: Add Engicam i.CoreM6 dts
Message-ID: <1476437243-13297-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is series add dts support for Engicam I.Core M6 qdl modules. just
rebased on top of linux-next of previous set[1].

[1] http://www.spinics.net/lists/kernel/msg2358233.html

Jagan Teki (5):
  ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual initial support
  ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo initial support
  ARM: dts: imx6qdl-icore: Add usbhost support
  ARM: dts: imx6qdl-icore: Add usbotg support
  ARM: dts: imx6qdl-icore: Add FEC support

 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/imx6dl-icore.dts   |  59 ++++++++
 arch/arm/boot/dts/imx6q-icore.dts    |  59 ++++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi | 271 +++++++++++++++++++++++++++++++++++
 4 files changed, 391 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore.dtsi

-- 
2.7.4

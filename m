From: jteki@openedev.com (Jagan Teki)
Date: Fri, 21 Oct 2016 13:35:50 +0530
Subject: [PATCH v8 0/3] ARM: dts: imx6q: Add Engicam i.CoreM6 dts 
Message-ID: <1477037153-20484-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

This is series add dts support for Engicam I.Core M6 qdl modules. just
rebased on top of linux-next.

Jagan Teki (3):
  ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual initial support
  ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo initial support
  ARM: dts: imx6qdl-icore: Add FEC support

 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/imx6dl-icore.dts   |  59 ++++++++
 arch/arm/boot/dts/imx6q-icore.dts    |  59 ++++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi | 265 +++++++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore.dtsi

-- 
2.7.4

From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 19 Sep 2012 15:02:05 +0530
Subject: [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB
Message-ID: <1348047128-25692-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds dt data to get MUSB working in omap4 and omap3

Changes from v2:
* Changes the subject of all the patches to include "ARM: dts:"
* Added reg property and interrupt property for "usb_otg_hs". Previously these
  were obtained from ti,hwmods property.
* Rebased on
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git devel-dt

Changes from v1:
Just removed the omap-usb2 dt data and sent that as a separate patch.

Kishon Vijay Abraham I (3):
  ARM: dts: Add twl6030-usb data
  ARM: dts: Add twl4030-usb data
  ARM: dts: omap: Add usb_otg and glue data

 arch/arm/boot/dts/omap3-beagle-xm.dts |    6 ++++++
 arch/arm/boot/dts/omap3-evm.dts       |    6 ++++++
 arch/arm/boot/dts/omap3-overo.dtsi    |    6 ++++++
 arch/arm/boot/dts/omap3.dtsi          |   11 +++++++++++
 arch/arm/boot/dts/omap4-panda.dts     |   10 ++++++++++
 arch/arm/boot/dts/omap4-sdp.dts       |   10 ++++++++++
 arch/arm/boot/dts/omap4.dtsi          |   12 ++++++++++++
 arch/arm/boot/dts/twl4030.dtsi        |   21 +++++++++++++++++++++
 arch/arm/boot/dts/twl6030.dtsi        |    5 +++++
 9 files changed, 87 insertions(+)

-- 
1.7.9.5

From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 6 Aug 2012 18:53:11 +0530
Subject: [PATCH 0/4] arm/dts: omap: add dt data for MUSB
Message-ID: <1344259395-4559-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds dt data for MUSB and related modules to
get MUSB working

These patches were initially part of
[PATCH v6 00/11] omap: musb: Add device tree support

These patches can be tested by applying it over
[PATCH v7 0/7] omap: musb: Add device tree support

These patches were developed on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git

If it needs to be rebased on some other tree, pls let me
know.

Performed MUSB device mode testing on omap4 panda,
omap4 sdp and omap3 beagle

Kishon Vijay Abraham I (4):
  arm/dts: omap: Add omap-usb2 dt data
  arm/dts: Add twl6030-usb data
  arm/dts: Add twl4030-usb data
  arm/dts: omap: Add usb_otg and glue data

 arch/arm/boot/dts/omap3-beagle.dts |    6 ++++++
 arch/arm/boot/dts/omap3-evm.dts    |    6 ++++++
 arch/arm/boot/dts/omap3.dtsi       |    8 ++++++++
 arch/arm/boot/dts/omap4-panda.dts  |   10 ++++++++++
 arch/arm/boot/dts/omap4-sdp.dts    |   10 ++++++++++
 arch/arm/boot/dts/omap4.dtsi       |   13 +++++++++++++
 arch/arm/boot/dts/twl4030.dtsi     |   21 +++++++++++++++++++++
 arch/arm/boot/dts/twl6030.dtsi     |    5 +++++
 8 files changed, 79 insertions(+)

-- 
1.7.9.5

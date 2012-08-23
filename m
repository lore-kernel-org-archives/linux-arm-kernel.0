From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 23 Aug 2012 12:29:07 +0300
Subject: [PATCH 0/6] ARM/dts: omap McBSP and audio support for BeagleBoard
Message-ID: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following series will add the needed entries for OMAP McBSP for DeviceTree
and enable the audio support on BeagleBoard when booted with DT.

Regards,
Peter
---
Peter Ujfalusi (6):
  ARM/dts: OMAP2: Add McBSP entries for OMAP2420 and OMAP2430 SoC
  ARM/dts: omap2420-h4: Include omap2420.dtsi file instead the common
    omap2
  ARM/dts: OMAP3: Add McBSP entries
  ARM/dts: OMAP4: Add McBSP entries
  ARM/dts: OMAP5: Add McBSP entries
  ARM/dts: omap3-beagle: Enable audio support

 arch/arm/boot/dts/omap2420-h4.dts  |    2 +-
 arch/arm/boot/dts/omap2420.dtsi    |   39 +++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi    |   83 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts |   14 ++++++
 arch/arm/boot/dts/omap3.dtsi       |   69 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi       |   47 ++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi       |   36 +++++++++++++++
 7 files changed, 289 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi

-- 
1.7.8.6

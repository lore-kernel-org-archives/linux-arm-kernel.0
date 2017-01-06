From: ahaslam@baylibre.com (Axel Haslam)
Date: Fri,  6 Jan 2017 10:40:52 +0100
Subject: [PATCH v2 0/2] ARM: davinvi: da850 add ohci DT nodes
Message-ID: <20170106094054.27767-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT node for the ohci controller and
enables it for the omapl138-lckd platform.

Changes v1 -> v2
* remove usb-phy node as it was added in merged patches for usb0 (musb)
* remove dependency on regulator patches as these are not needed for
  the lcdk board.
* remove dependency on merged ohci patches.

Axel Haslam (2):
  ARM: dts: da850: Add usb device node
  ARM: dts: da850-lcdk: Enable ohci for omapl138 lcdk

 arch/arm/boot/dts/da850-lcdk.dts | 4 ++++
 arch/arm/boot/dts/da850.dtsi     | 8 ++++++++
 2 files changed, 12 insertions(+)

-- 
2.9.3

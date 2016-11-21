From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 17:59:18 +0100
Subject: [PATCH 0/2] ARM: davinvi: da850 add ohci DT nodes
Message-ID: <20161121165920.29809-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT node for the ohci controller and
enables it for the omapl138-lckd platform.

DEPENDENCIES:

1. [PATCH v6 0/5] USB: ohci-da8xx: Add device tree support
https://lkml.org/lkml/2016/11/21/558

2. [PATCH v3 0/2] regulator: handling of error conditions for usb drivers
https://lkml.org/lkml/2016/11/4/465

Axel Haslam (2):
  ARM: dts: da850: Add usb device node
  ARM: dts: da850-lcdk: Enable ohci for omapl138 lcdk

 arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
 arch/arm/boot/dts/da850.dtsi     | 8 ++++++++
 2 files changed, 16 insertions(+)

-- 
2.9.3

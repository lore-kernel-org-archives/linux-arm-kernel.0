From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 30 Jul 2012 18:42:18 +0530
Subject: [PATCH 0/2] OMAP DT fixes
Message-ID: <1343653940-16614-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

These are couple of DT fixes for OMAP, first fixes a lockup
/boot failure on OMAP4 boards (SDP and panda) on mainline,
second is a long pending cleanup.

regards,
Rajendra

Rajendra Nayak (2):
  arm/dts: Mark vcxio, v2v1 and v1v8 regulators as always on
  arm/dts: Cleanup regulator naming and remove @0,1..

 arch/arm/boot/dts/omap3-beagle.dts |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts    |    4 ++--
 arch/arm/boot/dts/twl4030.dtsi     |    6 +++---
 arch/arm/boot/dts/twl6030.dtsi     |   29 ++++++++++++++++-------------
 4 files changed, 22 insertions(+), 19 deletions(-)

From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 Apr 2014 12:41:45 +0200
Subject: [PATCH 0/2] ARM: dts: Fix OMAP3 ISP functional clock configuration
Message-ID: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set enables rate propagation from the OMAP3 ISP functional clock to
the DPLL4 M5 clock. It copies Tomi Valkeinen's similar patch set for the OMAP
DSS functional clock from the "OMAP: OMAP3 DSS related clock patches" patch
series.

Laurent Pinchart (2):
  ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
  ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path

 arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
 arch/arm/boot/dts/omap3xxx-clocks.dtsi | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart

From: sathyap@ti.com (Sathya Prakash M R)
Date: Mon, 22 Jul 2013 11:33:15 +0530
Subject: [PATCH 0/2] Add DSS nodes for AM43x
Message-ID: <1374472997-9653-1-git-send-email-sathyap@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DSS support for AM437x is added in this patch series.
Patch #1 adds the hwmod entries and
patch #2 adds the DT entry.

Sathya Prakash M R (2):
  ARM: OMAP2+: AM43x - Add DSS hwmod
  ARM: DTS: AM43x: Add DSS node

 arch/arm/boot/dts/am4372.dtsi              |   27 +++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   85 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 3 files changed, 113 insertions(+)

-- 
1.7.9.5

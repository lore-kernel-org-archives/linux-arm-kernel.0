From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 14 Dec 2012 15:26:35 -0600
Subject: [RESEND PATCH 0/2] ARM: dts: Add PMU support for OMAP2+
Message-ID: <1355520397-5759-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree PMU support for OMAP2, OMAP3 and OMAP4460.

Tested with PERF on OMAP3430 Beagle Board and OMAP4460 Panda Board.
Boot tested only on OMAP2420 H4.

Jon Hunter (2):
  ARM: OMAP2+: Prepare for device-tree PMU support
  ARM: dts: OMAP2+: Add PMU nodes

 arch/arm/boot/dts/omap2.dtsi         |    5 +++++
 arch/arm/boot/dts/omap3.dtsi         |    6 ++++++
 arch/arm/boot/dts/omap4-panda-es.dts |    2 ++
 arch/arm/boot/dts/omap4460.dtsi      |   18 ++++++++++++++++++
 arch/arm/mach-omap2/pmu.c            |   14 +++++++++++---
 5 files changed, 42 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4460.dtsi

-- 
1.7.10.4

From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Jul 2012 18:41:08 +0530
Subject: [PATCH 0/2] OMAP4: DT update for L2 controller and local timers
Message-ID: <1341839470-5586-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of patches which updates the device tree support for OMAP4.
- Pl310 L2 cache controller DT support
- ARM cortex-A9 local timer DT support

Tested on OMAP4430 SDP. 

Santosh Shilimkar (2):
  ARM: OMAP4: Add L2 Cache Controller in Device Tree
  ARM: OMAP4: Add local timer support for Device Tree

 arch/arm/boot/dts/omap4.dtsi       |   13 +++++++++++++
 arch/arm/mach-omap2/omap4-common.c |    6 +++++-
 arch/arm/mach-omap2/timer.c        |   11 ++++++++---
 3 files changed, 26 insertions(+), 4 deletions(-)

-- 
1.7.9.5

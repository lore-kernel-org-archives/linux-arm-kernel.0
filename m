From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 31 Oct 2013 09:10:13 -0700
Subject: [PATCH 0/6] arm: zynq: BSP update
Message-ID: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are a few updates and fixes for the Zynq BSP coming
cherry-picked/ported from the Xilinx vendor tree.

	S?ren

Michal Simek (1):
  arm: zynq: Add support for zynq_cpu_kill function

Peter Crosthwaite (1):
  arm: zynq: platsmp: Fix CPU presence check

Soren Brinkmann (4):
  arm: zynq: Invalidate L1 in secondary boot
  arm: zynq: Use of_platform_populate instead of bus_probe
  arm: zynq: Set proper GIC flags
  arm: zynq: headsmp: Move .glbl out of actual code

 arch/arm/mach-zynq/common.c  | 16 ++++++++++------
 arch/arm/mach-zynq/common.h  |  2 ++
 arch/arm/mach-zynq/headsmp.S | 11 ++++++++---
 arch/arm/mach-zynq/platsmp.c | 13 +++++++++++--
 4 files changed, 31 insertions(+), 11 deletions(-)

-- 
1.8.4.1

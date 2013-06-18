From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Tue, 18 Jun 2013 10:37:58 +0530
Subject: [PATCH 0/2] ARM: AM33XX: clock: Add debugSS data to clk and hwmod
 database
Message-ID: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DebugSS data to clock-tree and hwmod data files.

Changes from RFC/V1 (No code change):
	- Based on comments, we have to follow DT and loadable module
	  approach for debugSS module as well, so separated out 2 patches
	  of clock-tree and hwmod data addition from the RFC patch-series.
	- Added Paul's Ack on clock-tree patch.
	- Rebased on top of Benoit's for-3.11/dts branch.

Link to original RFC -
http://archive.arm.linux.org.uk/lurker/message/20130304.113554.53c9ec25.en.html

Vaibhav Hiremath (2):
  ARM: AM33XX: clock: Add debugSS clock nodes
  ARM: AM33XX: hwmod: Add hwmod data for debugSS

 arch/arm/mach-omap2/cclock33xx_data.c      |   47 +++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   69 +++++++++++++++++++---------
 2 files changed, 89 insertions(+), 27 deletions(-)

From: andrei-tiberiu.breana@nxp.com (andrei-tiberiu.breana at nxp.com)
Date: Wed, 15 Feb 2017 14:00:24 +0200
Subject: [PATCH v2 0/2] Add AXI address filter support for MMDC profiling
Message-ID: <1487160026-9376-1-git-send-email-andrei-tiberiu.breana@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tiberiu Breana <andrei-tiberiu.breana@nxp.com>

This patch set is aimed at the i.MX6 MMDC driver:
Patch 1 is a bug fix for the "write-accesses" event definition.
Patch 2 adds AXI address filter support for MMDC profiling.

v2: added prefix for patch subjects.

Tiberiu Breana (2):
  ARM: imx: Fix mmdc_pmu_write_accesses event definition
  ARM: imx: Add AXI address filter support for MMDC profiling

 arch/arm/mach-imx/mmdc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.7.4

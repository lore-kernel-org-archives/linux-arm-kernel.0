From: andrei-tiberiu.breana@nxp.com (Tiberiu Breana)
Date: Tue, 14 Feb 2017 11:01:11 +0200
Subject: [PATCH 0/2] Add AXI address filter support for MMDC profiling
Message-ID: <1487062873-27641-1-git-send-email-andrei-tiberiu.breana@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is aimed at the i.MX6 MMDC driver:
Patch 1 is a bug fix for the "write-accesses" event definition.
Patch 2 adds AXI address filter support for MMDC profiling.

Tiberiu Breana (2):
  Fix mmdc_pmu_write_accesses event definition
  Add AXI address filter support for MMDC profiling

 arch/arm/mach-imx/mmdc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.7.4

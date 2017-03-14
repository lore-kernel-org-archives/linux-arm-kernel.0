From: hotran@apm.com (Hoan Tran)
Date: Tue, 14 Mar 2017 11:06:50 -0700
Subject: [PATCH 0/2] perf: xgene: Add support for SoC PMU of next generation
 of X-Gene
Message-ID: <1489514812-19671-1-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for SoC-wide (AKA uncore) Performance Monitoring
Unit in the next generation of X-Gene SoC.

Hoan Tran (2):
  Documentation: perf: xgene: Add support for SoC PMU of next generation of X-Gene
  perf: xgene: Add support for SoC PMU of next generation of X-Gene

 Documentation/perf/xgene-pmu.txt |  17 +-
 drivers/perf/xgene_pmu.c         | 645 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 586 insertions(+), 76 deletions(-)

-- 
1.9.1

From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Dec 2017 18:08:19 +0100
Subject: [PATCH 0/2] Perf-ARM SPE: Adjustments for two function implementations
Message-ID: <8a92bb8f-4295-6912-19a4-9103226a3c62@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2017 17:56:54 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
    in arm_spe_pmu_device_dt_probe()
  Delete an unnecessary return statement in __arm_spe_pmu_dev_probe()

 drivers/perf/arm_spe_pmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.15.1

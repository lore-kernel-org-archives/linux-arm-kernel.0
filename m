From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Jun 2016 11:17:11 -0600
Subject: [PATCH 0/3] coresight: fix for v4.7-rcX 
Message-ID: <1465924634-22310-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

These 3 patches address problems that lead to kernel crashes.  As such
I think there is value in fixing them in this cycle rather than waiting 
for next merge window.

Best regards,
Mathieu

Suzuki K Poulose (3):
  coresight: Fix NULL pointer dereference in _coresight_build_path
  coresight: Fix tmc_read_unprepare_etr
  coresight: Fix erroneous memset in tmc_read_unprepare_etr

 drivers/hwtracing/coresight/coresight-tmc-etr.c | 11 ++++-------
 drivers/hwtracing/coresight/coresight.c         |  6 +++---
 2 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.5.0

From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Dec 2017 11:05:41 -0700
Subject: [PATCH 0/4] coresight: next v4.15-rc4
Message-ID: <1513620345-1366-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good day,

Please see if you can add those to your tally for the 4.16 cycle.

Thanks,
Mathieu

Lukas Wunner (1):
  coresight: Deduplicate bus_find_device() by name matching

Pravin Shedge (1):
  coresight: etb10: remove duplicate includes

Robert Walker (1):
  coresight: Fix disabling of CoreSight TPIU

Vasyl Gomonovych (1):
  coresight: Use PTR_ERR_OR_ZERO()

 .../coresight/coresight-dynamic-replicator.c       |  4 +---
 drivers/hwtracing/coresight/coresight-etb10.c      |  1 -
 drivers/hwtracing/coresight/coresight-funnel.c     |  4 +---
 drivers/hwtracing/coresight/coresight-tpiu.c       | 17 +++++++++------
 drivers/hwtracing/coresight/coresight.c            | 25 +++++-----------------
 5 files changed, 18 insertions(+), 33 deletions(-)

-- 
2.7.4

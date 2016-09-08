From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu,  8 Sep 2016 16:50:37 -0600
Subject: [PATCH 0/2] coresight: next v4.8-rc5 
Message-ID: <1473375039-5783-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good afternoon,

These two patches complete the set that I'd like to see queued
for the 4.9 cycle.  They both apply cleanly on your 'char-misc-next'
branch (8e1d260738ca).

Thanks,
Mathieu

Baoyou Xie (1):
  coresight: tmc: mark symbols static where possible

Mathieu Poirier (1):
  coresight: perf: deal with error condition properly

 drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
 drivers/hwtracing/coresight/coresight-tmc-etf.c  | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c  | 2 +-
 drivers/hwtracing/coresight/coresight-tmc.c      | 4 ++--
 drivers/hwtracing/coresight/coresight.c          | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4

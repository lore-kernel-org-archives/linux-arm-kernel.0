From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Jan 2017 10:41:21 -0700
Subject: [PATCH 0/3] coresight: next v4.10-rc5
Message-ID: <1485193284-31636-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These are the patches to be queued for the 4.11 cycle.  Please have
a look when you have the opportunity.  The set applies on your
'char-misc-next' branch (8e27a236312c).

Regards,
Mathieu

Mathieu Poirier (1):
  coresight: etm4x: Fix timestamp configuration when working from perf

Mike Leach (1):
  coresight: etm4x: Fix enabling of cycle accurate tracing in perf.

Wang Nan (1):
  coresight: fix kernel panic caused by invalid CPU

 drivers/hwtracing/coresight/coresight-etm-perf.c |  1 +
 drivers/hwtracing/coresight/coresight-etm4x.c    | 10 +++++++---
 drivers/hwtracing/coresight/coresight-etm4x.h    |  1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.7.4

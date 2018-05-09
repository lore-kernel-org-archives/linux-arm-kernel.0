From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  9 May 2018 12:06:02 -0600
Subject: [PATCH 0/6] coresight: next v4.17-rc4
Message-ID: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning Greg,

These are the patches I would like you to consider for the upcoming 4.18 cycle.
As usual it applies cleanly to your char-misc/master branch.

Regards,
Mathieu

Arvind Yadav (1):
  coresight: use put_device() instead of kfree()

Leo Yan (1):
  coresight: Remove %px for printing pcsr value

Mathieu Poirier (4):
  coresight: Moving framework and drivers to SPDX identifier
  coresight tmc etr: Make memory check consistent in the same function
  coresight tmc etr: Fix uninitialised variable
  coresight tmc etr: Removing extra newline

 Documentation/trace/coresight-cpu-debug.txt         |  4 ++--
 drivers/hwtracing/coresight/coresight-cpu-debug.c   | 16 ++--------------
 .../coresight/coresight-dynamic-replicator.c        | 10 +---------
 drivers/hwtracing/coresight/coresight-etb10.c       | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm-cp14.c    | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm-perf.c    | 13 +------------
 drivers/hwtracing/coresight/coresight-etm-perf.h    | 13 +------------
 drivers/hwtracing/coresight/coresight-etm.h         | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 13 +------------
 drivers/hwtracing/coresight/coresight-etm3x.c       | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 13 +------------
 drivers/hwtracing/coresight/coresight-etm4x.c       | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm4x.h       | 13 +++----------
 drivers/hwtracing/coresight/coresight-funnel.c      | 13 +++----------
 drivers/hwtracing/coresight/coresight-priv.h        | 13 +++----------
 drivers/hwtracing/coresight/coresight-replicator.c  | 13 +++----------
 drivers/hwtracing/coresight/coresight-stm.c         | 13 +++----------
 drivers/hwtracing/coresight/coresight-tmc-etf.c     | 13 +------------
 drivers/hwtracing/coresight/coresight-tmc-etr.c     | 20 ++++----------------
 drivers/hwtracing/coresight/coresight-tmc.c         | 10 +---------
 drivers/hwtracing/coresight/coresight-tmc.h         | 13 +------------
 drivers/hwtracing/coresight/coresight-tpiu.c        | 13 +++----------
 drivers/hwtracing/coresight/coresight.c             | 21 +++++++--------------
 drivers/hwtracing/coresight/of_coresight.c          | 13 +++----------
 drivers/hwtracing/stm/ftrace.c                      | 10 +---------
 include/linux/coresight.h                           | 13 +++----------
 26 files changed, 63 insertions(+), 275 deletions(-)

-- 
2.7.4

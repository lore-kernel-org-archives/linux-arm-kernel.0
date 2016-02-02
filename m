From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  2 Feb 2016 14:13:54 -0700
Subject: [PATCH 0/7] coresight: next v4.5-rc2 
Message-ID: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

I would like to queue the following patches for 4.6, more will likely come later.

Thanks,
Mathieu

Mathieu Poirier (7):
  coresight: fixing indentation problem
  coresight: fixing lockdep error
  coresight: coresight_unregister() function cleanup
  coresight: release reference taken by 'bus_find_device()'
  coresight: remove csdev's link from topology
  coresight: removing bind/unbind options from sysfs
  coresight: implementing 'cpu_id()' API

 drivers/hwtracing/coresight/coresight-etb10.c      | 11 +----
 drivers/hwtracing/coresight/coresight-etm3x.c      | 21 ++++----
 drivers/hwtracing/coresight/coresight-etm4x.c      | 21 ++++----
 drivers/hwtracing/coresight/coresight-funnel.c     | 10 +---
 .../coresight/coresight-replicator-qcom.c          | 11 +----
 drivers/hwtracing/coresight/coresight-replicator.c | 16 +-----
 drivers/hwtracing/coresight/coresight-tmc.c        | 15 +-----
 drivers/hwtracing/coresight/coresight-tpiu.c       | 10 +---
 drivers/hwtracing/coresight/coresight.c            | 57 +++++++++++++++++++---
 include/linux/coresight.h                          |  3 ++
 10 files changed, 78 insertions(+), 97 deletions(-)

-- 
2.1.4

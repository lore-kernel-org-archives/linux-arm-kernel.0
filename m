From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 27 Mar 2017 11:09:30 -0600
Subject: [PATCH 0/3] coresight: next v4.11-rc4
Message-ID: <1490634573-11068-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning,

Just a few patches this time around - please consider for inclusion in the 4.12
cycle.  Everything applies on your 'char-misc-next' branch (57c0eabbd57e).

Thanks,
Mathieu

Mike Leach (1):
  coresight: Fixes coresight DT parse to get correct output port ID.

Olav Haugan (2):
  coresight: Replace sprintf with scnprintf
  coresight: etm3x: Correctly output counter values in sysfs node

 drivers/hwtracing/coresight/coresight-etb10.c      |  2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 80 ++++++++++++----------
 drivers/hwtracing/coresight/coresight-funnel.c     |  4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  2 +-
 drivers/hwtracing/coresight/of_coresight.c         |  2 +-
 7 files changed, 52 insertions(+), 42 deletions(-)

-- 
2.7.4

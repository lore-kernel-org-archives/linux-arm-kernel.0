From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 10 Oct 2017 14:32:11 -0600
Subject: [PATCH 0/2] coresight: next v4.14-rc4 
Message-ID: <1507667533-21707-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Greg,

Just a couple of patches for this cycle (to counterweight the barrage 
of the last cycle).

Please consider for the v4.15 cycle - applies on your char-misc-next
(c2e5df616e1a)

Regards,
Mathieu

Leo Yan (1):
  doc: coresight: correct usage for disabling idle states

Suzuki K Poulose (1):
  coresight: Extend the PIDR mask to cover relevant bits in PIDR2

 Documentation/trace/coresight-cpu-debug.txt        | 22 +++++++++++++++-----
 .../coresight/coresight-dynamic-replicator.c       |  4 ++--
 drivers/hwtracing/coresight/coresight-etb10.c      |  4 ++--
 drivers/hwtracing/coresight/coresight-etm3x.c      | 24 +++++++++++-----------
 drivers/hwtracing/coresight/coresight-funnel.c     |  4 ++--
 drivers/hwtracing/coresight/coresight-stm.c        |  8 ++++----
 drivers/hwtracing/coresight/coresight-tmc.c        |  4 ++--
 drivers/hwtracing/coresight/coresight-tpiu.c       |  4 ++--
 8 files changed, 43 insertions(+), 31 deletions(-)

-- 
2.7.4

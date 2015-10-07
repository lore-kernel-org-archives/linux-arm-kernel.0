From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  7 Oct 2015 09:26:37 -0600
Subject: [PATCH 0/6] coresight: next v4.3-rc4 
Message-ID: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning,

Please consider the following patches for merging in the 4.4 cycle.

Thanks,
Mathieu

Chunyan Zhang (1):
  Coresight: ETMv4: Prevent TRCRSCTLR0&1 from being accessed

Mathieu Poirier (5):
  coresight: fixing typographical error
  coresight: adding comments to remove ambiguity
  coresight: etm3x: adding cpu affinity to sysFS interface
  coresight: etm3x: breaking down sysFS status interface
  coresight: etm3x: making error message unambiguous

 .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |  77 +++++++++++++--
 drivers/hwtracing/coresight/coresight-etm3x.c      | 107 ++++++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.c      |  22 +++--
 drivers/hwtracing/coresight/coresight.c            |   5 +
 include/linux/coresight.h                          |   2 +-
 5 files changed, 154 insertions(+), 59 deletions(-)

-- 
1.9.1

From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 10 Nov 2016 11:18:46 -0700
Subject: [PATCH 0/8] coresight: next v4.9-rc4
Message-ID: <1478801934-26904-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning Greg,

Please consider the following set for inclusion in the 4.10 cycle. It
applies cleanly on today 'char-misc-next' branch (3372592a140d).

Regards,
Mathieu

Chunyan Zhang (1):
  coresight: stm: return error code instead of zero in .packet()

Mathieu Poirier (1):
  coresight: reset "enable_sink" flag when need be

Muhammad Abdul WAHAB (2):
  coresight: etm3x: indentation fix (extra space removed)
  coresight: etm3x: Adding missing features of Coresight PTM components

Suzuki K Poulose (1):
  coresight: Add support for ARM Coresight STM-500

Suzuki K. Poulose (3):
  coresight: tmc: Cleanup operation mode handling
  coresight: tmc: Get rid of mode parameter for helper routines
  coresight: tmc: Remove duplicate memset

 drivers/hwtracing/coresight/coresight-etm-perf.c   | 31 ++++-----
 drivers/hwtracing/coresight/coresight-etm.h        |  5 ++
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 12 +++-
 drivers/hwtracing/coresight/coresight-priv.h       |  4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  9 ++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    | 48 ++++++--------
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 43 +++++--------
 drivers/hwtracing/coresight/coresight-tmc.h        |  2 +-
 drivers/hwtracing/coresight/coresight.c            | 74 ++++++++++++++++++++--
 9 files changed, 144 insertions(+), 84 deletions(-)

-- 
2.7.4

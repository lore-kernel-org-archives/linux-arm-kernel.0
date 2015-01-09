From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:11 -0700
Subject: [PATCH 00/11] coresight: next 
Message-ID: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Good afternoon Greg,

Please consider the following coresight-related patches for inclusion
in your tree.  The set is based on v3.19-rc3.

Thanks,
Mathieu

Dan Carpenter (1):
  coresight-etm: unlock on error paths in mode_store()

Kaixu Xia (3):
  coresight: fix typo in comment in of_coresight.c
  coresight: fix comment in of_coresight.c
  coresight: fixing validity check on remote device

Mathieu Poirier (2):
  coresight-etm: Fix initial trace ID value
  coresight: Fixing wrong #ifdef/#endif placement

Wei Yongjun (4):
  coresight-etb: use module_amba_driver to simplify the code
  coresight-funnel: use module_amba_driver to simplify the code
  coresight-tmc: use module_amba_driver to simplify the code
  coresight-tpiu: use module_amba_driver to simplify the code

Xia Kaixu (1):
  coresight: remove the unused macro CORESIGHT_DEBUGFS_ENTRY

 drivers/coresight/coresight-etb10.c  | 12 +-----------
 drivers/coresight/coresight-etm3x.c  | 16 +++++++++++++---
 drivers/coresight/coresight-funnel.c | 12 +-----------
 drivers/coresight/coresight-tmc.c    | 12 +-----------
 drivers/coresight/coresight-tpiu.c   | 12 +-----------
 drivers/coresight/of_coresight.c     |  6 +++---
 include/linux/coresight.h            | 19 +++++--------------
 7 files changed, 25 insertions(+), 64 deletions(-)

-- 
1.9.1

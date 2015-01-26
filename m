From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 26 Jan 2015 09:22:16 -0700
Subject: [PATCH 0/9] coresight: next
Message-ID: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Good day,

These are the latest additions to the coresight sub-system.  Please
consider for inclusion.

Thanks,
Mathieu

Kaixu Xia (7):
  coresight: fix the replicator subtype value
  coresight: remove the unnecessary replicator property
  coresight: fix the link between orphan connection and newly added
    device
  coresight: remove the extra spaces
  coresight: fix the debug AMBA bus name
  coresight: remove the unnecessary function coresight_is_bit_set()
  coresight: fix function etm_writel_cp14() parameter order

Mathieu Poirier (1):
  coresight: fixing CPU hwid lookup in device tree

Paul Bolle (1):
  coresight-etm: remove check for unknown Kconfig macro

 Documentation/devicetree/bindings/arm/coresight.txt |  4 ----
 Documentation/trace/coresight.txt                   |  4 ++--
 drivers/coresight/coresight-etb10.c                 |  2 +-
 drivers/coresight/coresight-etm3x.c                 |  8 +-------
 drivers/coresight/coresight-priv.h                  |  2 +-
 drivers/coresight/coresight-replicator.c            |  2 +-
 drivers/coresight/coresight.c                       | 11 ++++++-----
 drivers/coresight/of_coresight.c                    | 16 +++++++++-------
 include/linux/coresight.h                           |  3 ---
 9 files changed, 21 insertions(+), 31 deletions(-)

-- 
1.9.1

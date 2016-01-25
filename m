From: eric.long@linaro.org (Eric Long)
Date: Mon, 25 Jan 2016 16:34:54 +0800
Subject: [PATCH v2 0/2] Modify static defined and wrong parameter used.
Message-ID: <cover.1453708131.git.eric.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both of the two patches optimize the code and remove the mistakes
and warnings detected by the check tools.

Changes since v1:
 - Adjust the patch by the changes not by the check tools.

Eric Long (2):
  coresight: "DEVICE_ATTR_RO" should defined as static.
  coresight: etm4x: Check every parameter used by dma_xx_coherent.

 drivers/hwtracing/coresight/coresight-etm4x.c |    2 +-
 drivers/hwtracing/coresight/coresight-tmc.c   |    6 +++---
 drivers/hwtracing/coresight/of_coresight.c    |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.9.5

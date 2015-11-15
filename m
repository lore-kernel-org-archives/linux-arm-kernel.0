From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 15 Nov 2015 16:01:32 -0500
Subject: [PATCH V5 0/2] add self test code for DMA engine drivers
Message-ID: <1447621295-6338-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from V4 (https://lkml.org/lkml/2015/11/12/18)
* Seperate the series from HIDMA driver

Sinan Kaya (2):
  dmaselftest: add memcpy selftest support functions
  dma: qcom_hidma: add self test hooks

 drivers/dma/dmaengine.h   |   2 +
 drivers/dma/dmaselftest.c | 638 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/qcom/Makefile |   2 +-
 drivers/dma/qcom/hidma.c  |   4 +
 4 files changed, 645 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/dmaselftest.c

-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

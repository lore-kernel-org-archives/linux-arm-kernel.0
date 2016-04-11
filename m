From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Mon, 11 Apr 2016 11:38:37 +0300
Subject: [PATCH v3 0/6] bam dma fixes and one dt extension
Message-ID: <1460363923-16296-1-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is version 3 with following changes:
 - fixed a typo in 2/6.
 - the patch which adds dt property is seperated in two, one
   which adding binding document and another one which modifing
   the driver - requested by Vinod.
 - fixed a typo in 5/6.
 - added collected Acked,Tested-by tags.

The v2 can be found at:
https://lkml.org/lkml/2016/4/5/922

regards,
Stan

Stanimir Varbanov (6):
  dmaengine: qcom: bam_dma: fix dma free memory on remove
  dmaengine: qcom: bam_dma: clear BAM interrupt only if it is raised
  dmaengine: qcom: bam_dma: document controlled-remotely dt property
  dmaengine: qcom: bam_dma: add controlled-remotely dt property
  dmaengine: qcom: bam_dma: use correct pipe FIFO size
  dmaengine: qcom: bam_dma: rename BAM_MAX_DATA_SIZE define

 .../devicetree/bindings/dma/qcom_bam_dma.txt       |    2 ++
 drivers/dma/qcom/bam_dma.c                         |   38 +++++++++++++-------
 2 files changed, 28 insertions(+), 12 deletions(-)

-- 
1.7.9.5

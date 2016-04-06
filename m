From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 6 Apr 2016 13:01:45 +0300
Subject: [RESEND 0/2] dmaengine: edma: cyclic slot limitation wa and TPTC pm
 fix
Message-ID: <1459936907-23920-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

I just noticed that the following two patch got lost somehow. If it is still
possible, it would be great to send them for 4.6 as they are correcting
important issues in the driver.

Thanks,
Peter
---
John Ogness (1):
  dmaengine: edma: special case slot limit workaround

Peter Ujfalusi (1):
  dmaengine: edma: Remove dynamic TPTC power management feature

 drivers/dma/edma.c | 63 ++++++++++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

-- 
2.8.0

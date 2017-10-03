From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 3 Oct 2017 11:35:36 +0300
Subject: [PATCH v2 0/2] dmaengine: edma/omap-dma: max_burst validity checking
Message-ID: <20171003083538.11044-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Hi,

Changes since v1:
- Fixed typo in commit message
- Separated from the 'dmaengine: core/edma/omap-dma: maximum SG len reporting'
  series

Both eDMA and sDMA have limit on the maximum burst size. The two patch
implements protection against too big burst size for both driver.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: edma: Implement protection for invalid max_burst
  dmaengine: omap-dma: Implement protection for invalid max_burst

 drivers/dma/edma.c     | 5 +++++
 drivers/dma/omap-dma.c | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.14.2


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

From: thierry.escande@collabora.com (Thierry Escande)
Date: Wed, 26 Oct 2016 19:04:06 +0200
Subject: [PATCH 0/2] ARM DMA mapping
Message-ID: <1477501448-30915-1-git-send-email-thierry.escande@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series introduces 2 changes in ARM DMA mapping. The first one is
about supporting cache maintenance after calling arm_dma_get_sgtable().
The other one handles VMA access protection in __get_dma_pgprot().

Heng-Ruey Hsu (2):
  ARM: dma-mapping: Support cache sync after arm_dma_get_sgtable
  ARM: dma-mapping: Handle prot with non-consistent dma attribute

 arch/arm/mm/dma-mapping.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.7.4

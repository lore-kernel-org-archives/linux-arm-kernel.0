From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 22 Mar 2016 11:18:28 +0800
Subject: [PATCH v3 0/1] arm64/dma-mapping: reduce an unnecessary conversion
 for coherent DMA
Message-ID: <1458616709-21888-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v2 -> v3:
1. Just add some description for this patch.

v1 -> v2:
1. Give up removing the conversion, because of thoughtless, instead moved it
into branch if (!is_device_dma_coherent(dev)). Thanks for Catalin's detailed
explanation, I directly take some relies as comment in the code.

Zhen Lei (1):
  arm64/dma-mapping: reduce an unnecessary conversion for coherent DMA

 arch/arm64/mm/dma-mapping.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.5.0

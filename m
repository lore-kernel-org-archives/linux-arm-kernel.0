From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 3 Dec 2014 17:58:55 +0800
Subject: [RFC] implement arm64_adjust_dma_zone as arm32 does?
Message-ID: <20141203175855.114d6717@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Will, Catalin,

If one platform has one limitation only some banks are DMA-able, for example
0-2GB. Under arm32, we can set the dma_zone_size, then arm_adjust_dma_zone()
will set the correct dma zone for us. But under arm64, we can't do it.


Or set dma-range in dts, then use swiotlb to bounce?

Could you kindly please give one suggestion about how to handle this
situation?

Thanks in advance,
Jisheng

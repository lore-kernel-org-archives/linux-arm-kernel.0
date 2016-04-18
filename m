From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 18 Apr 2016 10:20:27 +0800
Subject: [RFC 2/3] iommu: dma-iommu: move IOMMU/DMA-mapping code from
 ARM64 arch to drivers
In-Reply-To: <1455870164-25337-3-git-send-email-m.szyprowski@samsung.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
 <1455870164-25337-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5714446B.6040203@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?02?19? 16:22, Marek Szyprowski wrote:
> This patch moves all the IOMMU-based DMA-mapping code from arch/arm64/mm
> to drivers/iommu/dma-iommu-ops.c. This way it can be easily shared with
> ARM architecture, which will also use them.
>
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
IOMMU works good on drm/rockchip ARM64 platform with this patch. So

Tested-by: Mark Yao <mark.yao@rock-chips.com>

Thanks.

-- 
?ark Yao

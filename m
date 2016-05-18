From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 18 May 2016 14:59:25 -0400
Subject: [PATCH v2] arm64: Allow for different DMA and CPU bus offsets
In-Reply-To: <1463576010-115428-1-git-send-email-agraf@suse.de>
References: <1463576010-115428-1-git-send-email-agraf@suse.de>
Message-ID: <573CBB8D.4020409@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2016 8:53 AM, Alexander Graf wrote:
> ---
> 
> This patch may conflict with another patch titled "swiotlb: prefix dma_to_phys
> and phys_to_dma functions" which is in flight, but hasn't seen an update since
> March.

Thanks for the heads up. Due to missing API in DMA API, I couldn't make progress
with the series.

I need dma_map_resource API to get merged. After that one of the drivers
that actually uses dma_to_phys need to be changed to use dma_map_resource. 

Then the rest of the series can come.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

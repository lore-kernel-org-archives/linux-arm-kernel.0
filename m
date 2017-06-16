From: rkuo@codeaurora.org (Richard Kuo)
Date: Thu, 15 Jun 2017 19:20:16 -0500
Subject: [PATCH 31/44] hexagon: remove arch-specific dma_supported
 implementation
In-Reply-To: <20170608132609.32662-32-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-32-hch@lst.de>
Message-ID: <20170616002016.GB7343@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 03:25:56PM +0200, Christoph Hellwig wrote:
> This implementation is simply bogus - hexagon only has a simple
> direct mapped DMA implementation and thus doesn't care about the
> address.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/include/asm/dma-mapping.h | 2 --
>  arch/hexagon/kernel/dma.c              | 9 ---------
>  2 files changed, 11 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project

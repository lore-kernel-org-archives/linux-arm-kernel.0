From: rkuo@codeaurora.org (Richard Kuo)
Date: Thu, 15 Jun 2017 19:19:11 -0500
Subject: [PATCH 17/44] hexagon: switch to use ->mapping_error for error
 reporting
In-Reply-To: <20170608132609.32662-18-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-18-hch@lst.de>
Message-ID: <20170616001911.GA7343@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 03:25:42PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/include/asm/dma-mapping.h |  2 --
>  arch/hexagon/kernel/dma.c              | 12 +++++++++---
>  arch/hexagon/kernel/hexagon_ksyms.c    |  1 -
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project

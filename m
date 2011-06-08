From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 8 Jun 2011 18:03:23 +0200
Subject: [PATCH] omap: iovmm: s/sg_dma_len(sg)/sg->length/
In-Reply-To: <1307515436-20805-1-git-send-email-ohad@wizery.com>
References: <1307515436-20805-1-git-send-email-ohad@wizery.com>
Message-ID: <201106081803.24729.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

Thanks for the patch.

On Wednesday 08 June 2011 08:43:55 Ohad Ben-Cohen wrote:
> iovmm is erroneously using sg_dma_len with unmapped (DMA API-wise)
> SG entries, and will break if CONFIG_NEED_SG_DMA_LENGTH is enabled.
> 
> Fix that by using sg->length instead.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

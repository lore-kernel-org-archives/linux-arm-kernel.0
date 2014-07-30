From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 30 Jul 2014 19:14:41 +0530
Subject: [PATCH 0/3] dmaengine: sun6i: Misc fixes for the dma driver
In-Reply-To: <1406709023-7650-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1406709023-7650-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140730134441.GL8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 10:30:20AM +0200, Maxime Ripard wrote:
> Hi Dan, Vinod,
> 
> Here are the patches that you requested previously, plus an additional
> fix for a memory leak was spotted by Dan Carpenter.

Applied, thanks

-- 
~Vinod
> 
> Thanks,
> Maxime
> 
> Maxime Ripard (3):
>   dmaengine: sun6i: Remove switch statement from buswidth convertion
>     routine
>   dmaengine: sun6i: Free the interrupt before killing the tasklet
>   dmaengine: sun6i: Fix memory leaks
> 
>  drivers/dma/sun6i-dma.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> -- 
> 2.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

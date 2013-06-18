From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 00:10:47 -0700
Subject: [PATCH v2 0/3] minor omap dma fixes
In-Reply-To: <1371133031-29229-1-git-send-email-rnayak@ti.com>
References: <1371133031-29229-1-git-send-email-rnayak@ti.com>
Message-ID: <20130618071047.GA5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130613 07:23]:
> Hi,
> 
> Here are some minor omap dma fixes.
> 
> v2:
> Patch 3/3 was wrongly fixed by just changing the
> kfree() order. As Russell suggested the kfree()
> was that for platform_data and wrong to begin with.
> So Patch 3/3 now removes all instances of kfree() of
> platform_data.

Thanks applying into omap-for-v3.11/dma.

Regards,

Tony
 
> R Sricharan (2):
>   ARM: OMAP: dma: Remove the wrong dev_id check
>   ARM: OMAP: dma: Fix the dma_chan_link_map init order
> 
> Rajendra Nayak (1):
>   ARM: OMAP: dma: Remove the erroneous freeing of platform data
> 
>  arch/arm/plat-omap/dma.c |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> -- 
> 1.7.9.5
> 

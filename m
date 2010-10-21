From: peter.ujfalusi@nokia.com (Peter Ujfalusi)
Date: Thu, 21 Oct 2010 13:05:17 +0300
Subject: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
In-Reply-To: <20101008221746.GS7558@atomide.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101005181525.GL3117@atomide.com>
	<20101008221746.GS7558@atomide.com>
Message-ID: <201010211305.17559.peter.ujfalusi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I did missed this mail...

On Saturday 09 October 2010 01:17:46 ext Tony Lindgren wrote:

> Guys, as we're so late into getting 2.6.36 tagged, I'm thinking about just
> queueing these for 2.6.37 for the following reasons:
> 
> - The 24xx patch is a fix for commit c12abc0 that's was merged over a
>   year ago. We've lived with it for over a year now. What difference does
>   extra few more months make if we have it in 2.6.37 instead of 2.6.36?
> 
> - The second 34xx fix seems to happen only when disabling DMA on the fly.
>   Again, we've had support for 34xx in the mainline kernel for a few
>   years, and we're not seeing unrecoverable issues with MMC or USB or
>   any other code calling omap_dma_stop().
> 
> Sure these fix major issues with the DMA, but are these really critical
> for 2.6.36?
> 
> So if you really want me to argue for merging these into 2.6.36, please let
> me know some oops causing cases or data corruption that happens without
> these patches.

Well 2.6.36 is released.
I still would like to see this to be part of the 2.6.36.1 release. We can 
reproduce the DMA error in 2.6.36 with audio.

Tony: can you make sure it is going to part of 2.6.36.1?

Thanks,
P?ter

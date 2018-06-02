From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Sat, 02 Jun 2018 16:37:22 +0200
Subject: [PATCH] DMA: OMAP: fix OMAP1510 incorrect residue_granularity
In-Reply-To: <20180602142204.17460-1-jmkrzyszt@gmail.com>
References: <20180602142204.17460-1-jmkrzyszt@gmail.com>
Message-ID: <5702664.ZErQ22uL87@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 2, 2018 4:22:04 PM CEST Janusz Krzysztofik wrote:
> - by passing dma_caps.residue_granularity =
>   DMA_RESIDUE_GRANULARITY_DESCRIPTOR from drivers/dma/omap-dma.c.
> 
> Let's do the latter.
> 
> Created and tested against next-20180531 tag from linux-next tree.

I'm sorry, I missed 'git bisect reset' before testing the patch, it seems 
drivers/dma/omap-dma.c disappeared from next-20180531. I'll rework it and send 
again.

Thanks,
Janusz

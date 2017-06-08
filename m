From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Jun 2017 03:45:38 -0700
Subject: [PATCH 07/11] ARM: OMAP2+: Remove unused legacy code for DMA
In-Reply-To: <300ceefe-b015-60d2-2ebf-57dea9fd1d8b@ti.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-8-tony@atomide.com>
 <10f65a24-0459-5df7-378d-84933b83c070@ti.com>
 <20170608082432.GF3730@atomide.com>
 <20170608095618.GJ3730@atomide.com>
 <300ceefe-b015-60d2-2ebf-57dea9fd1d8b@ti.com>
Message-ID: <20170608104537.GK3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [170608 03:40]:
> unfortunately we still have conflict as the
> https://patchwork.kernel.org/patch/9734219/
> adds entries to omap24xx_sdma_map[] for - back then - valid non DT boot
> support.
> 
> I have rebased and reworked my patch locally on top of your v1, but
> things must go in in a certain order to avoid conflict.
> 
> The tsub conversion series in not yet in linux-next, but afaik Bin
> already applied it to somewhere.
> Leave the mach-omap2/dma.c cleanup for -rc1?

OK I'll save this for later then.

Regards,

Tony

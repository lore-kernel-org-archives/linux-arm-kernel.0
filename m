From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 31 Aug 2012 22:32:57 +0530
Subject: [PATCH v3 3/3] spi: spi-davinci: convert to DMA engine API
In-Reply-To: <5040E6C7.6030106@ti.com>
References: <1345684176-21472-1-git-send-email-mporter@ti.com>
 <1345684176-21472-4-git-send-email-mporter@ti.com>
 <503F75C0.1050507@ti.com> <20120830144307.GA26737@beef>
 <5040E00A.3080600@ti.com> <1346430709.15463.15.camel@vkoul-mobl4>
 <5040E6C7.6030106@ti.com>
Message-ID: <1346432577.15463.16.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-31 at 22:01 +0530, Sekhar Nori wrote:
> >> Yes, this was the problem. Since the SPI driver now depends on
> >> CONFIG_TI_EDMA for basic operation may be select CONFIG_TI_EDMA in
> >> Kconfig if SPI is enabled? That should do until the fallback to PIO
> is
> >> implemented.
> > Then this should be enabled for SPI. Care to send a patch
> 
> By 'this' you mean the Kconfig select? Then there should be no need of
> a
> new patch for this. It can be part of this patch itself, no? 
Either way is okay for me.

-- 
~Vinod Koul
Intel Corp.

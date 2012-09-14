From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 08:43:11 +0530
Subject: [PATCH 0/2] ARM: EXYNOS: Set the capability of pdm0 and pdm1
 as DMA_PRIVATE
In-Reply-To: <243801cd8cb9$f303e6d0$d90bb470$%kim@samsung.com>
References: <1346215585-31023-1-git-send-email-tushar.behera@linaro.org>
 <1346374330.15463.5.camel@vkoul-mobl4>
 <243801cd8cb9$f303e6d0$d90bb470$%kim@samsung.com>
Message-ID: <1347592391.1943.16.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-07 at 14:30 +0900, Kukjin Kim wrote:
> Vinod Koul wrote:
> > 
> > On Wed, 2012-08-29 at 10:16 +0530, Tushar Behera wrote:
> > > DMA clients pdma0 and pdma1 are internal to the SoC and are used only
> > > by dedicated peripherals. Since they cannot be used for generic
> > > purpose, their capability should be set as DMA_PRIVATE.
> > >
> > > The patches are rebased on top of v3.6-rc3.
> > Kukjin, if you ack them I can take thru my tree, other way round is fine
> > with me too.
> 
> Hi Vinod,
> 
> Looks good to me, please pick them into your tree with my ack.
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Okay applied both.


-- 
~Vinod

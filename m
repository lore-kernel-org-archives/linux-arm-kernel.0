From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 07 Sep 2012 14:30:53 +0900
Subject: [PATCH 0/2] ARM: EXYNOS: Set the capability of pdm0 and pdm1 as
 DMA_PRIVATE
In-Reply-To: <1346374330.15463.5.camel@vkoul-mobl4>
References: <1346215585-31023-1-git-send-email-tushar.behera@linaro.org>
 <1346374330.15463.5.camel@vkoul-mobl4>
Message-ID: <243801cd8cb9$f303e6d0$d90bb470$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul wrote:
> 
> On Wed, 2012-08-29 at 10:16 +0530, Tushar Behera wrote:
> > DMA clients pdma0 and pdma1 are internal to the SoC and are used only
> > by dedicated peripherals. Since they cannot be used for generic
> > purpose, their capability should be set as DMA_PRIVATE.
> >
> > The patches are rebased on top of v3.6-rc3.
> Kukjin, if you ack them I can take thru my tree, other way round is fine
> with me too.

Hi Vinod,

Looks good to me, please pick them into your tree with my ack.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> >
> > Tushar Behera (2):
> >   ARM: EXYNOS: Set the capability of pdm0 and pdm1 as DMA_PRIVATE
> >   DMA: PL330: Set the capability of pdm0 and pdm1 as DMA_PRIVATE
> >
> >  arch/arm/mach-exynos/dma.c |    2 ++
> >  drivers/dma/pl330.c        |    1 +
> >  2 files changed, 3 insertions(+), 0 deletions(-)
> >
> 
> --
> ~Vinod Koul
> Intel Corp.

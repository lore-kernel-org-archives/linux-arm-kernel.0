From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Jun 2012 13:28:06 +0900
Subject: [PATCH] ARM: S3C64XX: Add IRQ mapping for wm0010 on Cragganmore
References: <1339775065-13211-1-git-send-email-dp@opensource.wolfsonmicro.com>
Message-ID: <028c01cd4e9d$16c0f9b0$4442ed10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Dimitris Papastamos wrote:
> >
> > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> > ---
> >  arch/arm/mach-s3c64xx/mach-crag6410-module.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> b/arch/arm/mach-
> > s3c64xx/mach-crag6410-module.c
> > index f347336..7c8ea3c 100644
> > --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> > +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> > @@ -47,6 +47,7 @@ static struct spi_board_info wm1253_devs[] = {
> >  		.bus_num	= 0,
> >  		.chip_select	= 0,
> >  		.mode		= SPI_MODE_0,
> > +		.irq            = S3C_EINT(5),
                    ^^^^^^^^^^^^
If there is no reason, using tab is better at the mark ^

> >  		.controller_data = &wm0010_spi_csinfo,
> >  		.platform_data = &wm0010_crag_pdata,

I can't find platform_data in my tree (just v3.5-rc3), there is another
patch?

Now, just applying this patch is ok?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

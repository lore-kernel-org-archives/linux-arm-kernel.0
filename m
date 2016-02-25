From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 25 Feb 2016 11:24:41 -0800
Subject: [PATCH] MAINTAINERS: add maintainer entry for FREESCALE GPMI
 NAND driver
In-Reply-To: <20160218043612.GA735@sha-win-210.asiapac.arm.com>
References: <1455767715-621-1-git-send-email-han.xu@nxp.com>
 <20160218043612.GA735@sha-win-210.asiapac.arm.com>
Message-ID: <20160225192441.GM21465@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 12:36:13PM +0800, Huang Shijie wrote:
> On Thu, Feb 18, 2016 at 03:55:15AM +0000, Han Xu wrote:
> > Add a maintainer entry for FREESCALE GPMI NAND driver and add myself as a
> > maintainer.
> >
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7bd927e..49baa5b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4543,6 +4543,12 @@ L:     linuxppc-dev at lists.ozlabs.org
> >  S:   Maintained
> >  F:   drivers/dma/fsldma.*
> >
> > +FREESCALE GPMI NAND DRIVER
> > +M:   Han Xu <han.xu@nxp.com>
> > +L:   linux-mtd at lists.infradead.org
> > +S:   Maintained
> > +F:   drivers/mtd/nand/gpmi-nand/*
> > +
> >  FREESCALE I2C CPM DRIVER
> >  M:   Jochen Friedrich <jochen@scram.de>
> >  L:   linuxppc-dev at lists.ozlabs.org
> > --
> > 2.7.1
> >
> Acked-by: Huang Shijie <shijie.huang@arm.com>

Pushed to linux-mtd.git

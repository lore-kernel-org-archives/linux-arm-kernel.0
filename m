From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Apr 2010 10:08:07 +0200
Subject: [PATCH 02/16] drivers: serial: S5PC100 serial driver cleanup
In-Reply-To: <20100406155951.GS31126@trinity.fluff.org>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-3-git-send-email-m.szyprowski@samsung.com>
	<20100406155951.GS31126@trinity.fluff.org>
Message-ID: <001c01cad6f2$a1da52f0$e58ef8d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, April 06, 2010 6:00 PM Ben Dooks wrote:

> On Fri, Apr 02, 2010 at 08:48:50AM +0200, Marek Szyprowski wrote:
> > Remove unnecessary Kconfig entry. S5PC100 has exactly the same driver as
> > S3C6400/S3C6410/S5P6440.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/serial/Kconfig  |   10 +---------
> >  drivers/serial/Makefile |    1 -
> >  2 files changed, 1 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> > index f55c494..b68ea18 100644
> > --- a/drivers/serial/Kconfig
> > +++ b/drivers/serial/Kconfig
> > @@ -534,21 +534,13 @@ config SERIAL_S3C24A0
> >
> >  config SERIAL_S3C6400
> >  	tristate "Samsung S3C6400/S3C6410/S5P6440 Seria port support"
> 
> it would have been nice to update the list of supported devices above.

Ok. I will fix this in the next iteration of the patches.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

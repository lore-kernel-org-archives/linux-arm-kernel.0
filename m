From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Thu, 14 Dec 2017 12:17:06 +0100
Subject: [PATCH v3 07/11] thermal: armada: Update Kconfig and module
 description
In-Reply-To: <87po7ho93k.fsf@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-8-miquel.raynal@free-electrons.com>
 <87po7ho93k.fsf@free-electrons.com>
Message-ID: <20171214121706.529f9652@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, 14 Dec 2017 12:13:51 +0100
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On jeu., d?c. 14 2017, Miquel Raynal
> <miquel.raynal@free-electrons.com> wrote:
> 
> > Update Armada thermal driver Kconfig entry as well as the driver's
> > MODULE_DESCRIPTION content, now that 64-bit SoCs are also supported,
> > eg. Armada 7K and Armada 8K.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > ---
> >  drivers/thermal/Kconfig          | 4 ++--
> >  drivers/thermal/armada_thermal.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 315ae2926e20..44cad046f272 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -301,13 +301,13 @@ config DB8500_THERMAL
> >  	  thermal zone if trip points reached.
> >  
> >  config ARMADA_THERMAL
> > -	tristate "Armada 370/XP thermal management"
> > +	tristate "Armada 370/XP/7K/8K thermal management"  
> if you want to be exhaustive you should also add Armada 375 and 38x.

That is right, both are missing from the description, but wouldn't it
be better to just state "Armada SoCs" instead of patching that file
everythime a new SoC reuses this IP?

Thanks,
Miqu?l

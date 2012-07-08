From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 8 Jul 2012 21:52:46 +0200
Subject: [PATCH] Add nand platform on imx27 devicetree
In-Reply-To: <CAOMZO5BjcnB=CJ=i=V7Ct9oMvgnnbK8AjWvYJZdoVmZu=+_MQQ@mail.gmail.com>
References: <1341764963-11402-1-git-send-email-tremyfr@yahoo.fr>
 <CAOMZO5BjcnB=CJ=i=V7Ct9oMvgnnbK8AjWvYJZdoVmZu=+_MQQ@mail.gmail.com>
Message-ID: <20120708195246.GF4687@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 08, 2012 at 01:57:37PM -0300, Fabio Estevam wrote:
> On Sun, Jul 8, 2012 at 1:29 PM, Philippe Reynes <tremyfr@yahoo.fr> wrote:
> > Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
> > ---
> >  arch/arm/mach-imx/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index eff4db5..565422b 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -381,6 +381,7 @@ config MACH_IMX27_DT
> >         bool "Support i.MX27 platforms from device tree"
> >         select SOC_IMX27
> >         select USE_OF
> > +       select IMX_HAVE_PLATFORM_MXC_NAND
> 
> Bu doing this you end up selecting unnecessary code for dt.
> 
> I proposed a fix for this already:
> http://patchwork.ozlabs.org/patch/168645/
I only know understood your explaination why you don't want this patch
instead. So ok, I prefer your patch, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

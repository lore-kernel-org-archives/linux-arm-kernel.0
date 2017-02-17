From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 17 Feb 2017 09:55:19 +0100
Subject: [PATCH 20/21] ARM: sunxi: Enable dwmac-sun8i driver on
 sunxi_defconfig
In-Reply-To: <20170216190827.jaky5xyzqtuzhy76@lukather>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
 <20170216124859.14346-21-clabbe.montjoie@gmail.com>
 <20170216190827.jaky5xyzqtuzhy76@lukather>
Message-ID: <20170217085519.GD22723@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 08:08:27PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Feb 16, 2017 at 01:48:58PM +0100, Corentin Labbe wrote:
> > From: LABBE Corentin <clabbe.montjoie@gmail.com>
> > 
> > Enable the dwmac-sun8i driver in the sunxi default configuration
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm/configs/sunxi_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> > index da92c25..33bde86 100644
> > --- a/arch/arm/configs/sunxi_defconfig
> > +++ b/arch/arm/configs/sunxi_defconfig
> > @@ -40,6 +40,7 @@ CONFIG_ATA=y
> >  CONFIG_AHCI_SUNXI=y
> >  CONFIG_NETDEVICES=y
> >  CONFIG_SUN4I_EMAC=y
> > +CONFIG_DWMAC_SUN8I=m
> 
> I think I'd prefer to have it compiled statically, just like the other
> net drivers, and drivers in general.
> 
> Thanks!
> Maxime
> 

In previous sun8i-emac, someone request that CONFIG must be set as module because kernel went too big.
But I do not care to set it statically.

Regards
Corentin Labbe

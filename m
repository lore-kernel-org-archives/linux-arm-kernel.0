From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Mon, 10 Oct 2016 14:35:11 +0200
Subject: [PATCH v4 10/10] ARM: sunxi: Enable sun8i-emac driver on
 multi_v7_defconfig
In-Reply-To: <20161010123046.GH3462@lukather>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
 <1475828757-926-11-git-send-email-clabbe.montjoie@gmail.com>
 <20161010123046.GH3462@lukather>
Message-ID: <20161010123511.GA16103@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 02:30:46PM +0200, Maxime Ripard wrote:
> On Fri, Oct 07, 2016 at 10:25:57AM +0200, Corentin Labbe wrote:
> > Enable the sun8i-emac driver in the multi_v7 default configuration
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > index 5845910..f44d633 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -229,6 +229,7 @@ CONFIG_NETDEVICES=y
> >  CONFIG_VIRTIO_NET=y
> >  CONFIG_HIX5HD2_GMAC=y
> >  CONFIG_SUN4I_EMAC=y
> > +CONFIG_SUN8I_EMAC=y
> 
> Any reason to build it statically?
> 

No, just copied the same than CONFIG_SUN4I_EMAC that probably do not need it also.

Regards

Corentin Labbe

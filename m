From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 17:51:35 +0900
Subject: [PATCH v6 13/17] ARM: shmobile: marzen: Add to shmobile defconfig
In-Reply-To: <CAMuHMdWjxK5K4rhJt0VDbsSUX_Gzq8EXCPStN3bb_GUqq8tEog@mail.gmail.com>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
 <1400153532-23675-14-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXPm_=ejkcnOFOgfnsz9MUc8KpAjkuMcHMKJeaEmVbhQA@mail.gmail.com>
 <20140515225027.GA29432@verge.net.au>
 <20140516000409.GB29432@verge.net.au>
 <CAMuHMdWjxK5K4rhJt0VDbsSUX_Gzq8EXCPStN3bb_GUqq8tEog@mail.gmail.com>
Message-ID: <20140516085135.GA20299@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 10:43:33AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, May 16, 2014 at 2:04 AM, Simon Horman <horms@verge.net.au> wrote:
> > Add marzen to shmobile defconfig now that it supports multiplatform
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > ---
> > v6.1
> > * Also enable SPI_SH_HSPI and USB_RCAR_PHY
> >
> > v2 - v6
> > * No Change
> >
> > diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> > index b76fb9b..114e88e 100644
> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> 
> > +CONFIG_USB_RCAR_PHY=y
> > +CONFIG_USB_RCAR_GEN2_PHY=y
> 
> While I don't dispute the need for CONFIG_USB_RCAR_GEN2_PHY in
> shmobile_defconfig, this is not needed for Marzen, right?

The CONFIG_USB_RCAR_GEN2_PHY was moved from above (by savedefconfig).
I decided to include that change due to proximity to the new
CONFIG_USB_RCAR_PHY line. But perhaps it would have been better not to.

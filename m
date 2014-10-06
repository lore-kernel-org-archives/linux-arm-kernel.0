From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Oct 2014 10:48:32 +0900
Subject: [PATCH] ARM: shmobile: r7s72100: Remove r7s72100-genmai.dtb for
 ARCH_SHMOBILE_LEGACY
In-Reply-To: <3422011.ptz11KJ6Ks@avalon>
References: <1412348152-15326-1-git-send-email-geert+renesas@glider.be>
 <3422011.ptz11KJ6Ks@avalon>
Message-ID: <20141006014832.GB22040@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 04, 2014 at 03:17:57PM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Friday 03 October 2014 16:55:52 Geert Uytterhoeven wrote:
> > Forgotten by commit ad8c3af8b75ff26c ("ARM: shmobile: r7s72100: Remove
> > legacy board support").
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up as a DT cleanup for v3.19.

> > ---
> >  arch/arm/boot/dts/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index a9125b8d394e5c4a..dc619a48d2c5bb70 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -357,7 +357,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
> >  	s5pv210-smdkc110.dtb \
> >  	s5pv210-smdkv210.dtb \
> >  	s5pv210-torbreck.dtb
> > -dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
> > +dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
> >  	r8a73a4-ape6evm.dtb \
> >  	r8a73a4-ape6evm-reference.dtb \
> >  	r8a7740-armadillo800eva.dtb \
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

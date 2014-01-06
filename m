From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Jan 2014 16:57:46 +0900
Subject: [PATCH 15/21] ARM: shmobile: Remove Koelsch reference DTS
In-Reply-To: <2111872.r7nHcLFZor@avalon>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
 <11196073.PIXxcg54ZL@avalon> <20131227022356.GF9184@verge.net.au>
 <2111872.r7nHcLFZor@avalon>
Message-ID: <20140106075745.GO24653@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 29, 2013 at 10:42:02PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 27 December 2013 11:23:57 Simon Horman wrote:
> > On Thu, Dec 26, 2013 at 03:48:58PM +0100, Laurent Pinchart wrote:
> > > On Tuesday 24 December 2013 20:00:43 Sergei Shtylyov wrote:
> > > > On 24-12-2013 18:19, Simon Horman wrote:
> > > > > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > > 
> > > > > Now that the DTS file r8a7790-koelsch.dts can be used with
> > > > > board-koelsch.c and board-koelsch-reference.c, proceed with removing
> > > > > r8a7790-koelsch-reference.dts.
> > > > > 
> > > > > Signed-off-by: Laurent Pinchart
> > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > > ---
> > > > > 
> > > > >   arch/arm/boot/dts/Makefile | 1 -
> > > > >   1 file changed, 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > > > index 909d910..5839077 100644
> > > > > --- a/arch/arm/boot/dts/Makefile
> > > > > +++ b/arch/arm/boot/dts/Makefile
> > > > > @@ -225,7 +225,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) +=
> > > > > emev2-kzm9d.dtb
> > > > > \
> > > > > 
> > > > >   	r8a7779-marzen.dtb \
> > > > >   	r8a7779-marzen-reference.dtb \
> > > > >   	r8a7791-koelsch.dtb \
> > > > > 
> > > > > -	r8a7791-koelsch-reference.dtb \
> > > > > 
> > > > >   	r8a7790-lager.dtb \
> > > > >   	r8a7790-lager-reference.dtb \
> > > > 
> > > > Hm, the previous commit removed that file itself but forgot to remove it
> > > > from the Makefile.
> > > 
> > > Indeed, this problem doesn't seem to be present in the patches I've sent.
> > > Simon, has something gone wrong during a rebase ?
> > 
> > Sorry about that.
> > 
> > Could you supply an incremental patch to remove the file itself?
> 
> Sure. I've sent the patch.

Thanks, got it.

> Could you please also pick "[PATCH v6 15.1/17] ARM: 
> shmobile: Add GPIO keys to Koelsch DTS" from the list ?

Done.

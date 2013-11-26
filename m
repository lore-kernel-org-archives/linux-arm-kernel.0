From: horms@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 09:27:05 +0900
Subject: [RFC 16/17] ARM: shmobile: Let Marzen multiplatform boot with
 Marzen DTB
In-Reply-To: <87k3fxnf5c.wl%kuninori.morimoto.gx@renesas.com>
References: <1385342312-1967-1-git-send-email-horms+renesas@verge.net.au>
 <1385342312-1967-17-git-send-email-horms+renesas@verge.net.au>
 <87k3fxnf5c.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20131126002703.GH15227@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 10:56:19PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Let the multiplatform Marzen support boot with the legacy DTS for
> > Marzen as well as the Marzen reference DTS.
> > 
> > Based on work for the Koelsch board by Laurent Pinchart.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> (snip)
> > --- a/arch/arm/mach-shmobile/board-koelsch-reference.c
> > +++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
> > @@ -38,6 +38,7 @@ static void __init koelsch_add_standard_devices(void)
> >  }
> >  
> >  static const char * const koelsch_boards_compat_dt[] __initconst = {
> > +	"renesas,koelsch",
> >  	"renesas,koelsch-reference",
> >  	NULL,
> >  };
> 
> You are modifying koelsch file in marzen patch ?

Sorry, my mistake. I'll fix that.

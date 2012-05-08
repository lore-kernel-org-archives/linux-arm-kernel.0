From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 16:16:54 -0700
Subject: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make
 board_onenand_init() visible to board code
In-Reply-To: <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
 <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
 <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com>
Message-ID: <20120508231653.GP5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [120427 02:33]:
> On Wed, Apr 25, 2012 at 9:59 AM, Enric Balletb? i Serra
> <eballetbo@gmail.com> wrote:
> >
> > Tony, as this is a fix ,may be included ?
> >
> > Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> > Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> >
> > Cheers,
> > ? ?Enric
> 
> Hi Tony, Russel:
> 
> This patch is a requirement for patch:
> 
> [RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flash
> storage memory
> 
> which is really important since newer IGEPv2 boards have changed their
> flash memory from OneNAND to NAND.
> 
> This patch-set is necessary to make the board work, otherwise it
> doesn't even boot.
> 
> Could we please include these patches?

Thanks for the patience, applying now into board branch finally.

Regards,

Tony

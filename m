From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2018 12:03:53 +0200
Subject: [PATCH 1/2] [RFC] arm64: renesas: Move SoC Kconfig symbols to
 drivers/soc/renesas/
In-Reply-To: <CAMuHMdWaXCu9KukLioxkcNoDQt4wKs2C9vrRbQRVJ+8+ux4PAQ@mail.gmail.com>
References: <20181011085508.5234-1-geert+renesas@glider.be>
 <20181011085508.5234-2-geert+renesas@glider.be>
 <20181011135448.sah5unjhclllvqty@verge.net.au>
 <20181015154048.hkmht7cml272xbcg@verge.net.au>
 <CAMuHMdWaXCu9KukLioxkcNoDQt4wKs2C9vrRbQRVJ+8+ux4PAQ@mail.gmail.com>
Message-ID: <20181017100351.hisqesa3psw4pb5h@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 11:56:43AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Oct 15, 2018 at 5:40 PM Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Oct 11, 2018 at 03:54:55PM +0200, Simon Horman wrote:
> > > On Thu, Oct 11, 2018 at 10:55:07AM +0200, Geert Uytterhoeven wrote:
> > > > For consistency with other vendors, which have a single Kconfig symbol
> > > > in arch/arm64/Kconfig.platforms.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > Note that drivers/clk/ is included before drivers/soc/.  Hence when
> > > > COMPILE_TEST=y, questions will be asked about clock drivers before they
> > > > can be auto-selected by SoC support.
> > > >
> > > > Question: Should we introduce a family-specific Kconfig symbol for R-Car
> > > >       Gen3 (ARCH_RCAR_GEN1), which could be used for enabling
> > >
> > > s/1/3/?
> 
> Sure.
> 
> > > >
> > > >       RST_RCAR?
> > >
> > > Given that it would be consistent with R-Car Gen 1 and 2,
> > > that seems like a good idea to me.
> >
> > there has been no other feedback on this series.
> > How would you like to proceed?
> 
> I will add a new symbol ARCH_RCAR_GEN3 for v2?

Good plan.

> Any comments about PATCH 2/2?

Thanks, I have now commented.

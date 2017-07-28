From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Jul 2017 15:47:36 +0200
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
In-Reply-To: <CAGb2v66=h_5df=B0Us-kvvFg9r_qSUroDzn-xvQLSpD1d8DhBQ@mail.gmail.com>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
 <CAGb2v66=h_5df=B0Us-kvvFg9r_qSUroDzn-xvQLSpD1d8DhBQ@mail.gmail.com>
Message-ID: <20170728134736.GC32230@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 05:53:40PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 28, 2017 at 5:28 PM, Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> > Hello
> >
> > The current way to find if the phy is internal is to compare DT phy-mode
> > and emac_variant/internal_phy.
> > But it will negate a possible future SoC where an external PHY use the
> > same phy mode than the internal one.
> >
> > This patchs series adds a new way to find if the PHY is internal, via its
> > compatible.
> 
> You've already joined in on the discussion for the patch "net: stmmac:
> dwmac-rk: Add internal phy support". It is pretty much the same issue.
> Please wait for it to come to a proper conclusion. At least then we can
> agree on something so different platforms with the same problem don't
> have diverging solutions.

Yes, this is important.

     Andrew

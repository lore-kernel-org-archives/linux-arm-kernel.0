From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Mar 2017 10:45:29 +0200
Subject: [PATCH/RFC v2 1/2] arm64: dts: r8a7795: Add support for R-Car H3
 ES2.0
In-Reply-To: <CAMuHMdWvR71V_JyR6273KmdtGfrrT_vaU2vcDTpNt2MAG0WdLg@mail.gmail.com>
References: <1490362665-4422-1-git-send-email-geert+renesas@glider.be>
 <1490362665-4422-2-git-send-email-geert+renesas@glider.be>
 <1612430.SNEha5n02K@avalon> <20170329081352.GF6512@verge.net.au>
 <CAMuHMdWvR71V_JyR6273KmdtGfrrT_vaU2vcDTpNt2MAG0WdLg@mail.gmail.com>
Message-ID: <20170329084529.GG6512@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 10:31:02AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Mar 29, 2017 at 10:13 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Mar 27, 2017 at 11:48:12AM +0300, Laurent Pinchart wrote:
> >> On Friday 24 Mar 2017 14:37:44 Geert Uytterhoeven wrote:
> >> > Update r8a7795.dtsi so it corresponds to R-Car H3 ES2.0 or later:
> >> >   - The following devices no longer exist on ES2.0, and are thus removed:
> >> >     fcpf2, fcpvd3, fcpvi2, fdp1-2, usb3-if1, vspd3, vspi2.
> >> >   - The DU <-> VSPD topology is different on ES2.0, hence remove the
> >> >     "vsps" property from the DU node until the driver can handle this.
> >>
> >> I think I'll need a different compatible string between ES1.x and ES2 for the
> >> DU. It could make sense to move the whole DU node to *-es1.dtsi. We can decide
> >> about that later when I'll have a DU driver prototype ready.
> >
> > That makes sense to me.
> >
> > Geert, will you respin this?
> 
> Sure. The DTS parts are definitely not v4.12 material.
>   - For ES2.0, they depend on clk/pfc/rcar-sysc updates.
>   - For ES1.x, I don't want to break people's setup (scripts copying
>     r8a7795-salvator-x.dtb) prematurely.

Ok.

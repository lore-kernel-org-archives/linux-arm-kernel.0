From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Dec 2014 09:23:39 +0900
Subject: [PATCH] clk: shmobile: Add r8a7793 support
In-Reply-To: <CAMuHMdVdFii0rxO8NrdcWiCO0HWQYrv-y3W0Dh6zt_31tTG81g@mail.gmail.com>
References: <1418035363-3678-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdVDA4PwUZ8A0WPumEN9nYrQyX+UNYp7Dt=0TxO9nCuZrg@mail.gmail.com>
 <CAH1o70JgXPfRVQ+EyeQVA6Sa9irDb3hVBn7vAbDDuu7k=Z7x3w@mail.gmail.com>
 <CAMuHMdVdFii0rxO8NrdcWiCO0HWQYrv-y3W0Dh6zt_31tTG81g@mail.gmail.com>
Message-ID: <20141209002338.GB8897@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 02:30:14PM +0100, Geert Uytterhoeven wrote:
> Hi Kaneko-san,
> 
> On Mon, Dec 8, 2014 at 12:53 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > 2014-12-08 20:13 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> >> On Mon, Dec 8, 2014 at 11:42 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> >>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >>>
> >>> R-Car M2N (r8a7793) clock is handled in R-Car Gen2 clock driver.
> >>
> >> Thanks for your patch!
> >>
> >>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >>
> >> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> Can you please also send a patch to update the binding documentation in
> >> Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt?
> >
> > This patch updates Makefile only, not added dtsi for r8a7793.
> > Is the update of the document necessary?
> 
> Not at this moment. I was just trying to be proactive ;-)

Kaneko-san,

I think that the update to renesas,rcar-gen2-cpg-clocks.txt should be a
one line change. I can prepare a patch if you prefer not to.

From: horms@verge.net.au (Simon Horman)
Date: Fri, 2 Feb 2018 10:57:27 +0100
Subject: [PATCH] arm64: defconfig: enable R8A77970 SoC
In-Reply-To: <CAMuHMdVfqxi8v5wiFui2Qev5TCQ-yMm81Q5o=WAVJeZxYrgXBw@mail.gmail.com>
References: <20180202093602.19256-1-horms+renesas@verge.net.au>
 <CAMuHMdVfqxi8v5wiFui2Qev5TCQ-yMm81Q5o=WAVJeZxYrgXBw@mail.gmail.com>
Message-ID: <20180202095726.hqar4h7jtpwibqys@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 02, 2018 at 10:55:22AM +0100, Geert Uytterhoeven wrote:
> On Fri, Feb 2, 2018 at 10:36 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Enable the Renesas R-Car V3H (R8A77970) SoC in the ARM64 defconfig.
> 
> Wrong subject, wrong body ;-)

Sorry, cut and paste madness.

> 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >  Based on renesas-devel-20180130v2-v4.15
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 6356c6da34ea..45a423f845c7 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -52,6 +52,7 @@ CONFIG_ARCH_RENESAS=y
> >  CONFIG_ARCH_R8A7795=y
> >  CONFIG_ARCH_R8A7796=y
> >  CONFIG_ARCH_R8A77970=y
> > +CONFIG_ARCH_R8A77980=y
> >  CONFIG_ARCH_R8A77995=y
> >  CONFIG_ARCH_STRATIX10=y
> >  CONFIG_ARCH_TEGRA=y
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

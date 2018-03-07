From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 07 Mar 2018 08:52:20 +0100
Subject: [GIT PULL] Reset controller changes for v4.17
In-Reply-To: <CAK8P3a1J8_26+30_KhubMppfXThbpg8psV8KQhRne08mJFPufA@mail.gmail.com>
References: <1519300351.7447.8.camel@pengutronix.de>
 <CAK8P3a1J8_26+30_KhubMppfXThbpg8psV8KQhRne08mJFPufA@mail.gmail.com>
Message-ID: <1520409140.3395.0.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-03-06 at 17:48 +0100, Arnd Bergmann wrote:
> On Thu, Feb 22, 2018 at 12:52 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Dear arm-soc maintainers,
> > 
> > Please consider merging this tag for v4.17. It contains level reset
> > support for Meson8b SoCs, which was already implemented for the newer
> > Meson GX, removing the distinction between the two families in the
> > meson-reset driver. Also the ASPEED LPC reset controller is enabled for
> > AST2400 and AST2500 SoCs by extending the compatibles list in the
> > simple-reset driver.
> > 
> 
> Pulled into next/drivers, thanks!
> 
> 
> > ----------------------------------------------------------------
> > Reset controller changes for v4.17
> > 
> > This enables level resets on Meson8b SoCs. Level resets have been
> > previously implemented for the newer Meson GX SoCs, so this removes
> > the distinction between the two families in the meson-reset driver.
> > 
> > Also enables the ASPEED LPC reset controller on ASPEED AST2400 and
> > AST2500 SoCs, by adding compatibles to the simple-reset driver.
> 
> You seem to be saying the same thing here and above in different words,
> No need for that when you have a proper tag description.

Got it, thanks!

regards
Philipp

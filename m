From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 14:00:03 -0800
Subject: [PATCH v3 0/6] arm: Add Artpec-6 SoC
In-Reply-To: <2697188.EpDoHh0fx4@wuerfel>
References: <cover.1455205057.git.larper@axis.com> <2697188.EpDoHh0fx4@wuerfel>
Message-ID: <20160224220003.GO10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej,

On Thu, Feb 11, 2016 at 05:20:27PM +0100, Arnd Bergmann wrote:
> On Thursday 11 February 2016 17:06:15 Lars Persson wrote:
> > Basic support for the Axis Artpec-6 ARM SoC. Timers, interrupts, UARTs and
> > ethernet are wired up.
> > 
> > Changes since v2:
> > - Create a syscon binding for the system controller.
> > - Clock patches split out to new patch series "clk: Add Artpec-6 SoC support".
> 
> Looks all good to me now, impressive for v3 on a new platform port!
> 
> We'll apply it in the next few days, unless further review comments come in.

Indeed, nice and clean. I have two minor nits:

1) We prefix with ARM:, not arm:. I fixed this up for you. I also added ARM:
   dts: artpeg: ... on the dts changes. Not a huge deail on those.

2) Several of the patches lacked description. Subject pretty much says it all,
   but it's still nice to have a sentence or two as description. Again, not
   a huge deal, and I applied anyway, but for the future think about it.


That being said, I've applied the series across next/soc, next/dt and
next/defconfig. Thanks!


-Olof

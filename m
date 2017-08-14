From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Aug 2017 12:33:05 -0400 (EDT)
Subject: [PATCH 02/30] ARM: assembler: introduce adr_l, ldr_l and str_l
 macros
In-Reply-To: <CAKv+Gu_3gb4K_2=igLWMjtXuEcdhnqeoVgaW7Lvqx56AQU-VZg@mail.gmail.com>
References: <20170814125411.22604-1-ard.biesheuvel@linaro.org>
 <20170814125411.22604-3-ard.biesheuvel@linaro.org>
 <20170814152950.GT6321@e103592.cambridge.arm.com>
 <CAKv+Gu87G93X36TdAEiMC46Uz_PqXEi_4LSftnUdkQ8HRCxWiA@mail.gmail.com>
 <20170814155002.GV6321@e103592.cambridge.arm.com>
 <alpine.LFD.2.20.1708141217150.17016@knanqh.ubzr>
 <CAKv+Gu_3gb4K_2=igLWMjtXuEcdhnqeoVgaW7Lvqx56AQU-VZg@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1708141231110.17016@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Aug 2017, Ard Biesheuvel wrote:

> On 14 August 2017 at 17:18, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Mon, 14 Aug 2017, Dave Martin wrote:
> >
> >> On Mon, Aug 14, 2017 at 04:38:02PM +0100, Ard Biesheuvel wrote:
> >> > That's a trick, actually, which I failed to add a comment for.
> >
> > Shame shame shame !
> >
> >> > We use .arm sections in the thumb2 kernel, and using these macros
> >> > there would result in the wrong offset to be used. Adding the .w
> >> > suffix forces an error in the assembler which even results in a fairly
> >> > meaningful error message complaining about using .w in ARM code.
> >>
> >> Ewww... I think it'd be best to add a comment explaining that.
> >
> > Absolutely!
> >
> 
> Yeah, mea culpa.
> 
> But if people have better ideas how to avoid this situation, I am all ears.

Just document it.  ;-)


Nicolas

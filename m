From: clemens.gruber@pqgruber.com (Clemens Gruber)
Date: Sat, 7 Jan 2017 21:59:30 +0100
Subject: imx: RS-485 problems during TX, maybe DMA related
In-Reply-To: <CAOMZO5CY3ys6moE133LwSKcS4egv56JdmhPMRG0TmAnfD+ZBAw@mail.gmail.com>
References: <20170104160024.GA13442@archie.localdomain>
 <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
 <20170106225026.GA3804@archie.localdomain>
 <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
 <20170107134557.GA12299@archie.localdomain>
 <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
 <20170107153434.GA13307@archie.localdomain>
 <CAOMZO5CY3ys6moE133LwSKcS4egv56JdmhPMRG0TmAnfD+ZBAw@mail.gmail.com>
Message-ID: <20170107205930.GA12367@archie.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 02:48:03PM -0200, Fabio Estevam wrote:
> On Sat, Jan 7, 2017 at 1:34 PM, Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> > Hi Fabio,
> >
> > On Sat, Jan 07, 2017 at 12:57:10PM -0200, Fabio Estevam wrote:
> >> The MX6QDL_PAD_CSI0_DAT16__UART4_CTS_B option is only valid in dte mode.
> >
> > Ah, the input select is limited in that way, I see.
> >
> > You wrote that you tried rts-gpios.
> > What about setting cts-gpios to gpio6 2 in the DT?
> >
> > Or can you remux RX and TX to be switched to work in dte mode?
> 
> I managed to get RS485 in half-duplex working with rts-gios. Will send
> a patch shortly.

Great!

Did you observe the same effect I described, with the doubling of
characters in the front and the leftovers from previous transmissions at
the end?

Thanks,
Clemens

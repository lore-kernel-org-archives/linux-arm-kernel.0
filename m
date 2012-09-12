From: miguel.gaio@efixo.com (Miguel GAIO)
Date: Wed, 12 Sep 2012 09:23:35 +0200
Subject: [PATCH 1/3] gpio: 74x164: Add support for the daisy-chaining
In-Reply-To: <CACRpkdZ6umqe0Td=OkF-5yYU624M2AAakVjt17rOjejcNdawzg@mail.gmail.com>
References: <1347309341-15447-1-git-send-email-maxime.ripard@free-electrons.com>
 <1347309341-15447-2-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdbo1sj6gbucoF3WVLbHzFXtddZiUQ-=h9gn-+A4Z7qBnQ@mail.gmail.com>
 <CACRpkdZ6umqe0Td=OkF-5yYU624M2AAakVjt17rOjejcNdawzg@mail.gmail.com>
Message-ID: <1347434615.10232.1.camel@mgo-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-11 at 23:51 +0200, Linus Walleij wrote:
> On Tue, Sep 11, 2012 at 7:05 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Sep 10, 2012 at 10:35 PM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> >
> >> The shift registers have an output pin that, when enabled, propagates
> >> the values of its internal register to the pins. If another value comes
> >> to the register while the output pin is disabled, this new value will
> >> makae the older shift into the next register in the chain.
> >>
> >> This patch adds support for daisy-chaining the registers, using the
> >> regular SPI chip select mechanism to manage the output pin, and the
> >> registers-number dt property to set the number of chained registers.
> >>
> >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >
> > OK cool, but I just realized that this driver was added just two
> > years ago by Gabor and Miguel, so I'd like to get their feedback
> > before continuing.
> 
> Tentatively applied waiting for feedback from Miguel...

All is ok for me.

Miguel


> 
> Thanks!
> Linus Walleij

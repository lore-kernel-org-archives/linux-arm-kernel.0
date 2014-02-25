From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 18:03:08 +0100
Subject: [GIT PULL] integrator base patches for v3.15
In-Reply-To: <CACRpkdbtv2ZQbt0=7QhBZSRRAdONgKeKCO9yj=UwWRAU2WOWwA@mail.gmail.com>
References: <CACRpkdYeaMqTNUTqBSg6vNa9=VucjpFFkx3diHJJNgZTg+iq1w@mail.gmail.com>
 <201402241117.48617.arnd@arndb.de>
 <CACRpkdbtv2ZQbt0=7QhBZSRRAdONgKeKCO9yj=UwWRAU2WOWwA@mail.gmail.com>
Message-ID: <201402251803.08685.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 February 2014, Linus Walleij wrote:
> >
> > irqchip: VIC: export vic_init_cascaded
> >
> > vic_init_cascaded is called by integrator impd1 code that can
> > be a loadable module, so the function has to be exported.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Can either of you pls apply this directly to the ARM SoC tree?
> 

Applied on next/drivers now.

	ARnd

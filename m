From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 12:53:03 +0100
Subject: [GIT PULL] integrator base patches for v3.15
In-Reply-To: <201402241117.48617.arnd@arndb.de>
References: <CACRpkdYeaMqTNUTqBSg6vNa9=VucjpFFkx3diHJJNgZTg+iq1w@mail.gmail.com>
 <201402241117.48617.arnd@arndb.de>
Message-ID: <CACRpkdbtv2ZQbt0=7QhBZSRRAdONgKeKCO9yj=UwWRAU2WOWwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 11:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 13 February 2014, Linus Walleij wrote:
>>       irqchip: vic: update the base IRQ member correctly
>>       irqchip: support cascaded VICs
>>       ARM: integrator: register the IM-PD1 VIC
>
> I got a randconfig build error for CONFIG_IMPD1=m. Ok to apply this
> fix on top?

Sure sorry for missing this ...

> 8<---
>
> irqchip: VIC: export vic_init_cascaded
>
> vic_init_cascaded is called by integrator impd1 code that can
> be a loadable module, so the function has to be exported.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Can either of you pls apply this directly to the ARM SoC tree?

Yours,
Linus Walleij

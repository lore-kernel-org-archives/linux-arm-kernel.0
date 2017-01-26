From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Jan 2017 13:55:33 +0100
Subject: [PATCH 05/22] clocksource: Add driver for the Cortina Gemini
In-Reply-To: <20170122121717.10249-1-linus.walleij@linaro.org>
References: <20170122121717.10249-1-linus.walleij@linaro.org>
Message-ID: <20170126125533.GH2021@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 01:17:17PM +0100, Linus Walleij wrote:
> This is a rewrite of the Gemini timer
> driver in arch/arm/mach-gemini/timer.c trying to do everything
> the device tree way:
> 
> - Make every IO-access relative to a base address and dynamic
>   so we can do a dynamic ioremap and get going.
> - Do not poke around directly in the global syscon registers,
>   access them using the syscon regmap style design pattern for
>   the one register we need to check.
> - Find register range and interrupt from the device tree.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> clocksource maintainers: please just apply this when you feel
> pleased with it. These portions are functionally orthogonal to
> the series, it is just in a series for context.
> ---

Hi Linus,

applied for 4.11.

Thanks !

  -- Daniel

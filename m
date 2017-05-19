From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 May 2017 23:57:21 -0700
Subject: [PATCH] ARM: configs: add a gemini defconfig
In-Reply-To: <20170514214502.26243-1-linus.walleij@linaro.org>
References: <20170514214502.26243-1-linus.walleij@linaro.org>
Message-ID: <20170519065721.GC9628@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 14, 2017 at 11:45:02PM +0200, Linus Walleij wrote:
> It makes sense to have a stripped-down defconfig for just Gemini, as
> it is a pretty small platform used in NAS etc, and will use appended
> device tree. It is also quick to compile and test. Hopefully this
> defconfig can be a good base for distributions such as OpenWRT.
> 
> I plan to add in the config options needed for the different
> variants of Gemini as we go along.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this where apropriate for v4.12.

I'm usually not super-eager on adding new defconfigs, but since this seems to
be an active platform it seems like the right thing to do.

Applied to fixes.


-Olof

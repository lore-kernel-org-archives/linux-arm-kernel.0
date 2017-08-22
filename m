From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Aug 2017 15:31:10 +0200
Subject: [PATCH] ARM: dts: augment Ux500 to use DT cpufreq
In-Reply-To: <20170822072820.15801-1-linus.walleij@linaro.org>
References: <20170822072820.15801-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a1Km8Kmzodg6F8UjfO+oDxua8UVgWjUQ4cjZ8hh4t3dCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 9:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds the operating points to the Ux500 device tree and
> deletes the old special-purpose cpufreq node, as we can now
> use the generic DT cpufreq driver.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for v4.14, I have
> no other ux500 DTS patches coming this merge window as far
> as I know. It is just using standard bindings.

applied to next/dt, thanks!

    Arnd

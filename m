From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Mar 2017 15:08:52 -0700
Subject: [PATCH] ARM: dts: add the AB8500 clocks to the device tree
In-Reply-To: <20170226000209.20534-1-linus.walleij@linaro.org>
References: <20170226000209.20534-1-linus.walleij@linaro.org>
Message-ID: <20170313220852.GB13064@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2017 at 01:02:09AM +0100, Linus Walleij wrote:
> This adds the AB8500 clocks to the device tree using the new
> bindings from the clk subsystem, making audio work again.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC guys: please consider this for late merge/early fix.
> 
> Lee had audio working at some point in the past, but there is no
> way of fixing it backward or for stable. However: applying this
> fixes it for v4.11.
> 
> ChangeLog v1->v2:
> - Rename DT node to clock-controller.

Thanks, I'm interpreting this as a fix (at least this early in the release
cycle, and merging it for 4.11 fixes).


-Olof

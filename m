From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Sep 2012 18:10:41 -0700
Subject: [PATCH] ARM: ux500: 8500: use hsit_a_2 group for HSI
In-Reply-To: <1347620075-18022-1-git-send-email-linus.walleij@stericsson.com>
References: <1347620075-18022-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120917011041.GD19186@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 12:54:35PM +0200, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard@stericsson.com>
> 
> Due to specific constraint, pin HSIT_ACWAKE0_a is
> not driven by HSI block but as a GPIO.
> 
> Cc: arm at kernel.org
> Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC maintainers - I'll take this fixup through the pinctrl
> tree if you don't mind.

Sure, you should know best yourself if you're likely to have conflicts with
other updates in this merge window anyway.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof

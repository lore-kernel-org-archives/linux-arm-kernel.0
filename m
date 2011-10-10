From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 10 Oct 2011 19:57:51 +0800
Subject: [PATCH v10] pinctrl: add a driver for the U300 pinmux
In-Reply-To: <1318235485-2112-1-git-send-email-linus.walleij@stericsson.com>
References: <1318235485-2112-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4w9y_DTgX-zz7BUFM2M+UPgFF=JDmD5RptQ3SR5-0h1UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/10 Linus Walleij <linus.walleij@stericsson.com>:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> This adds a driver for the U300 pinmux portions of the system
> controller "SYSCON". It also serves as an example of how to use
> the pinmux subsystem. This driver also houses the platform data
> for the only supported platform.
>
> This deletes the old U300 driver in arch/arm/mach-u300 and
> replace it with a driver using the new subsystem.
>
> The new driver is considerably fatter than the old one, but it
> also registers all 467 pins of the system and adds the power
> and EMIF pin groups and corresponding functions. The idea
> is to use this driver as a a reference for other
> implementation so it needs to be as complete and verbose
> as possible.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Barry Song <21cnbao@gmail.com>

> ---
> ChangeLog v9 -> v10
> - Removed debug register dump (review from Barry Song)
> - Allocate sizeof(*ptr) instead of sizeof(struct foo)


-barry

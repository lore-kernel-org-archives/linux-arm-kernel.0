From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 04 Aug 2015 16:26:41 +0200
Subject: [PATCH] ARM/clocksource: use automatic DT probing
In-Reply-To: <1438348470-6656-1-git-send-email-linus.walleij@linaro.org>
References: <1438348470-6656-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <55C0CBA1.9000602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2015 03:14 PM, Linus Walleij wrote:
> The ARM core kernel already calls clocksource_of_init() so why
> go to all the trouble of locating and probing this node in the
> machine. CLOCKSOURCE_OF_DECLARE() will take care of it in the
> clocksource driver, and thus we can also get rid of the
> dangling header file <linux/clksrc-dbx500-prcmu.h>
>
> Suggested-by: Arnd Bergmann <arndb@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Clocksource maintainers: please ACK this so I can take it through
> ARM SoC with a bunch of other cleanups.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

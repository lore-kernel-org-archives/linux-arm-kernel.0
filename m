From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 31 Jul 2015 15:56:41 +0200 (CEST)
Subject: [PATCH] ARM/clocksource: use automatic DT probing
In-Reply-To: <1438348470-6656-1-git-send-email-linus.walleij@linaro.org>
References: <1438348470-6656-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.11.1507311556130.3825@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Jul 2015, Linus Walleij wrote:

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

Acked-by: Thomas Gleixner <tglx@linutronix.de>

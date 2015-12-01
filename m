From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 22:37:22 +0100
Subject: [PATCH] ARM/clocksource: use automatic DT probing for ux500 PRCMU
In-Reply-To: <1448978424-9756-1-git-send-email-linus.walleij@linaro.org>
References: <1448978424-9756-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <9370021.MVNa6PAx4P@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 15:00:24 Linus Walleij wrote:
> The ARM core kernel already calls clocksource_of_init() so why
> go to all the trouble of locating and probing this node in the
> machine. CLOCKSOURCE_OF_DECLARE() will take care of it in the
> clocksource driver, and thus we can also get rid of the
> dangling header file <linux/clksrc-dbx500-prcmu.h>
> 
> Suggested-by: Arnd Bergmann <arndb@linaro.org>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: I have only this Ux500 patch queued for v4.5.
> Can you please apply it directly to the proper place in
> ARM SoC?
> ---

Applied to next/cleanup, thanks!

	Arnd

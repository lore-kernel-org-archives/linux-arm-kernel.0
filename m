From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Feb 2014 17:35:46 +0100
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <201402061708.05845.arnd@arndb.de>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <000001cf230c$60ec1ca0$22c455e0$%han@samsung.com>
 <201402061708.05845.arnd@arndb.de>
Message-ID: <2319331.qA0baufx1C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 February 2014 17:08:05 Arnd Bergmann wrote:
> 
> Finally, I have recently encountered a couple of drivers
> (BACKLIGHT_LM3630A, BACKLIGHT_LP855X, BACKLIGHT_LP8788) that use
> the PWM interfaces but are missing a 'depends on PWM'. This is
> strictly speaking a different problem, but we could try to solve
> it at the same time.
> 

D'oh. I just realized this is the bug that started the thread
with Linus' patch. Apparently I found one more instance that
he didn't find though.

	Arnd

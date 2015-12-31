From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 16:49:43 +0100
Subject: [PATCH] ARM: realview: set up cache correctly on the PB11MPCore
In-Reply-To: <1451505909-3820-1-git-send-email-linus.walleij@linaro.org>
References: <1451505909-3820-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <3175687.xW1SWKiffP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 December 2015 21:05:09 Linus Walleij wrote:
> The L2 cache comes up in a "safe mode" on the PB11MPCore, as
> it has several issues. This sets it up properly with the right
> size and associativity, also requiring the outer sync to be
> disabled for the machine to boot properly.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: Russell has merged the outer cache sync disable
> patch so it would be nice if you'd merge this directly on top
> of the branch holding the PB11MPCore device tree, so that the
> cache is feature complete for v4.5.

Applied on next/dt, thanks!

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2011 07:01:30 +0200
Subject: [PATCH 2/2] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <1303076969-13039-1-git-send-email-linus.walleij@stericsson.com>
References: <1303076969-13039-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201104180701.30384.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 17 April 2011, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This rewrites the U300 GPIO driver using gpiolib and the irq_chip
> abstractions, makes it runtime-configured rather than compile-time,
> and moves it to the drivers/gpio subsystem where it belongs,
> depopulating the ARM tree of one more driver.
> 
> Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

The new driver looks good, but it would be nice to see the actual changes you did.
You can do that by either passing the -M flag to git-format-patch, or by splitting
up the patch into separate move and rewrite bits, in either order.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd

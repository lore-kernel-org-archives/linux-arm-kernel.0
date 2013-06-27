From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jun 2013 14:18:05 +0200
Subject: [PATCH 1/3] ARM: integrator: set local side PCI addresses right
In-Reply-To: <1372201538-25946-1-git-send-email-linus.walleij@linaro.org>
References: <1372201538-25946-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201306271418.05950.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Linus Walleij wrote:
> This alters the local side address of the iospace to zero,
> non prefetchable memory local side address to 0x00000000 and
> prefetchable memory local side address to 0x10000000,
> so as to match the values actually poked in by the driver.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks!

	Arnd

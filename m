From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Jan 2016 13:16:39 +0100
Subject: [PATCH] ARM: realview: fix device tree build
In-Reply-To: <1453377887-23878-1-git-send-email-linus.walleij@linaro.org>
References: <1453377887-23878-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <6894504.B4kHmy7D43@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 January 2016 13:04:47 Linus Walleij wrote:
> As it happens, two obj-$(CONFIG_FOO) += foo.o variables are
> above obj-y := core.o, which doesn't work: the += directives
> need to add something to the build and doesn't work if obj-y
> is not set first, so move the obj-y to be on top and everything
> builds nicely again.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC guys, please apply this directly for fixes.
> ---

Applied, thanks!

	Arnd

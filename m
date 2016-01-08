From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 11:46:50 +0100
Subject: [PATCH 2/2] ARM: versatile: enable the right LEDs
In-Reply-To: <1452002529-3335-3-git-send-email-linus.walleij@linaro.org>
References: <1452002529-3335-1-git-send-email-linus.walleij@linaro.org>
 <1452002529-3335-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <8577276.zfs8bcEaSQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 15:02:09 Linus Walleij wrote:
> The Versatile now only has device tree boot support, and the
> device tree version does not support CONFIG_LEDS_VERSATILE.
> Instead select CONFIG_LEDS_SYSCON and MFD_SYSCON, so we can
> get LEDs support from the same generic driver that drives
> most other ARM reference boards.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 

Applied to next/defconfig, thanks!

	Arnd

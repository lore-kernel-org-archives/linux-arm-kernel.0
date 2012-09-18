From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 12:24:36 +0000
Subject: [PATCH] ARM: ux500: tidy up pin sleep modes
In-Reply-To: <1347967598-24691-1-git-send-email-linus.walleij@stericsson.com>
References: <1347967598-24691-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201209181224.36834.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This named the sleep mode pin configurations as slpm rather
> than sleep to correspond better with the settings from the
> datasheet. It also defines an optional sleep mode for the SPI
> controller SPI2.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Arnd, Olof: again a patch I'd like to take through the pinctrl
> tree for simplicity.

Acked-by: Arnd Bergmann <arnd@arndb.de>

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 12:23:59 +0000
Subject: [PATCH] ARM: ux500: fix spi2 pin group
In-Reply-To: <1347962986-12280-1-git-send-email-linus.walleij@stericsson.com>
References: <1347962986-12280-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201209181223.59918.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard@stericsson.com>
> 
> GPIO216_AG12 is configured as a gpio for SPI2, so select
> the spi2_oc1_2 pin group instead of spi2_oc1_1
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Olof, Arnd:
> 
> Again I'd prefer to take this through the pinctrl tree if it's
> OK with you. We are deploying pinctrl internally and ironing out
> bugs as we test more and more use cases.

Acked-by: Arnd Bergmann <arnd@arndb.de>

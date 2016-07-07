From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 14:05:24 +0200
Subject: [PATCH] ARM: dts: Ux500: fix up TVK sensor data
In-Reply-To: <1467637857-8205-1-git-send-email-linus.walleij@linaro.org>
References: <1467637857-8205-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5196188.7Jojq5Lqu2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 4, 2016 3:10:57 PM CEST Linus Walleij wrote:
> - Fix the I2C address and supply line names for the AK8974
> 
> - Sets up the interrupt lines to the different components as they
>   actually are connected, I was confused for some time by the fact
>   that several lines were connected with <NM> 0 Ohm resistors, which
>   means NOT MOUNTED and is thus not 0 Ohm at all but infinite ohms,
>   i.e. not connected at all.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC folks:
> please apply this directly to the ARM SoC tree because I don't
> think I will have more DT patches for Ux500 this merge window.
> Your ux500/dt branch would be the best candidate to land this.
> 

Applied to next/dt, thanks!

	Arnd

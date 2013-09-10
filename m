From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Sep 2013 23:47:14 +0200
Subject: [PATCH 3/7] misc: ixp4-beeper: use gpiolib strictly
In-Reply-To: <1378816226-8016-1-git-send-email-linus.walleij@linaro.org>
References: <1378816226-8016-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201309102347.14920.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 September 2013, Linus Walleij wrote:
> Request and free the GPIO line used for the beeper properly.
> Then use the gpiolib API to flip the output of the GPIO pin
> instead of relying on hacks to poke the register bits.
> 
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Arnd/Greg: seeking your ACK to take this through the GPIO tree
> as part of the attempt at cleaning out custom GPIO implementations.


Acked-by: Arnd Bergmann <arnd@arndb.de>

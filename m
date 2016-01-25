From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 09:53:57 +0100
Subject: [PATCH 2/2] ARM: versatile: move restart to the device tree
In-Reply-To: <1453710656-14280-1-git-send-email-linus.walleij@linaro.org>
References: <1453710656-14280-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <3893384.79tPr7Rxbf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 January 2016 09:30:56 Linus Walleij wrote:
> We have a power/reset driver for the Versatile family
> in drivers/power/reset so let's just activate that driver
> and use it and get rid of some non-DT remnants.
> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 

Good idea.

Acked-by: Arnd Bergmann <arnd@arndb.de>

I don't see patch 1/2 here. Maybe that was caught by the list
spam filters in some way?

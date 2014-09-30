From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 13:08:07 +0200
Subject: [PATCH V4] bcma: use chipcommon node from DT for SoC GPIO chip
In-Reply-To: <1412074548-14614-1-git-send-email-zajec5@gmail.com>
References: <1412072546-3529-1-git-send-email-zajec5@gmail.com>
 <1412074548-14614-1-git-send-email-zajec5@gmail.com>
Message-ID: <2792546.1ci4Y7Hkk3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 12:55:48 Rafa? Mi?ecki wrote:
> This will allow us to define GPIO-attached devices (LEDs, buttons) in
> the the device tree.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> This is based on top of
> [PATCH v6] bcma: register bcma as device tree driver
> that I hope will reach wireless-next git tree.
> 
> V2: Describe axi chilren and make gpio a child of chipcommon core.
> V3: Make chipcommon a GPIO controller (avoid extra sub-child)
>     Speed up finding OF node in driver_gpio.c
> V4: Simplify setting of_node in driver_gpio.c
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

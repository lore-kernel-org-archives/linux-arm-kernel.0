From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 14:24:06 +0200
Subject: [PATCH 2/8 v2] leds: add device tree bindings for register bit
 LEDs
In-Reply-To: <1409659354-23553-3-git-send-email-linus.walleij@linaro.org>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
 <1409659354-23553-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <5686741.QjIvGO0Jfo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 14:02:28 Linus Walleij wrote:
> +LED sub-node properties:
> +
> +Required properties:
> +- compatible : must be "register-bit-led"
> +- offset : register offset to the register controlling this LED
> +- mask : bit mask for the bit controlling this LED in the register
> +  typically 0x01, 0x02, 0x04 ...
> 

How does the driver know whether to do byte or word sized accesses?

	Arnd

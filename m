From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 24 May 2017 15:18:49 -0700
Subject: [PATCH 2/2] ARM: dts: add core I2C devices to the APQ8060
 Dragonboard
In-Reply-To: <20170515075034.3753-1-linus.walleij@linaro.org>
References: <20170515075034.3753-1-linus.walleij@linaro.org>
Message-ID: <20170524221849.GA12920@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 15 May 00:50 PDT 2017, Linus Walleij wrote:

> The APQ8060 Dragonboard has an Atmel AT24c128 EEPROM and a
> Wolfson Micro WM8903 codec connected to its GSBI8 I2C bus.
> Add entries for these to the device tree. The interrupt line
> from the WM8903 chip is not routed anywhere on this design
> so it can not be used.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 10 Aug 2011 09:54:52 +0200
Subject: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
	implementations
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Message-ID: <CAKnu2Mofp+f7Khu1d0j9Pz3Pr03EawBgkRPWEqDy7mf4DzoETA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/9 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h. ?This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

reaks compile of plat-nomadik due to missing u32, feel free to fold in
the below fix. With that it's
Tested-by: Linus Walleij <linus.walleij@linaro.org>
for Nomadik, U300 and Ux500.

From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 10:50:02 +0200
Subject: [PATCH 2/2] ARM: bcm2835: enable GPIO/pinctrl
In-Reply-To: <1348805412-7804-2-git-send-email-swarren@wwwdotorg.org>
References: <1348805412-7804-1-git-send-email-swarren@wwwdotorg.org>
 <1348805412-7804-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdaUkz5kVZqMeDB6X0B6=0YX4_KxM0eG9RmJMJ4ujkvShw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 6:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> Enable GPIO and pinctrl in Kconfig.
>
> Add required <mach/gpio.h> for gpiolib.
>
> Instantiate the BCM2835 GPIO module in bcm2835.dtsi.
>
> Add a pinctrl definition to bcm2835-rpi-b.dts that sets up all of the
> board's required pinmux configuration. GPIO aren't specified; that's
> left to gpio_request().
>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

This thing does not apply to my tree because of deps in
other trees (I guess ARM SoC).

You have my ACK:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

If you figure out a way to get it into a later part of the
merge window, else it'll need to wait for v3.7-rc1.

Yours,
Linus Walleij

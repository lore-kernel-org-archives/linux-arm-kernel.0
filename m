From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Dec 2011 00:17:01 +0100
Subject: [PATCH] GPIO: sa1100: implement proper gpiolib gpio_to_irq
 conversion
In-Reply-To: <20111218182457.GV14542@n2100.arm.linux.org.uk>
References: <20111218182457.GV14542@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZ-W_JHYj2SHZb7wSVHKmnv7UiCgHE84DDcJfX0d_oTSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2011 at 7:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> From: Russell King <rmk+kernel@arm.linux.org.uk>
>
> The existing gpio_to_irq() implementation on sa1100 only translates
> validly for internal GPIOs. ?Since this sub-arch enables GPIOLIB
> support, this results in buggy translations for non-internal GPIOs.
>
> Get rid of the private gpio_to_irq() implementation, replacing it
> with the .to_irq method in the sa1100 gpio chip instead.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks Russell!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

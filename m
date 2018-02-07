From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Feb 2018 14:55:35 +0100
Subject: [PATCH 2/2] usb: gadget: udc: atmel: convert to use GPIO
 descriptors
In-Reply-To: <20180201093432.21919-2-ludovic.desroches@microchip.com>
References: <20180201093432.21919-1-ludovic.desroches@microchip.com>
 <20180201093432.21919-2-ludovic.desroches@microchip.com>
Message-ID: <CACRpkdYe-caycymfzosGTgnQUgf2jrLU9vfJEsT+bupqexCAxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 1, 2018 at 10:34 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Use GPIO descriptors instead of relying on the old method.
> Include irq.h header since it is needed and was indirectly
> included through of_gpio.h.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you for doing gpiod conversions. Making the world
a better place!

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Dec 2013 18:26:49 +0100
Subject: [RFC 03/18] GPIO: gpio-generic: Add label to platform data
In-Reply-To: <1387815830-8794-4-git-send-email-pawel.moll@arm.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-4-git-send-email-pawel.moll@arm.com>
Message-ID: <CACRpkdb4w26vuOtR1bAhQ6k=1uQx=np4WwoabvH8pOq8HK54=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 5:23 PM, Pawel Moll <pawel.moll@arm.com> wrote:

> When registering more than one platform device, it is
> useful to set the gpio chip label in the platform data.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Anton Vorontsov <anton@enomsg.org>

Good point. But what about also adding device tree support for
naming the chips while you're at it?

I imagine a generic gpiochip property in
Documentation/devicetree/bindings/gpio/gpio.txt

Yours,
Linus Walleij

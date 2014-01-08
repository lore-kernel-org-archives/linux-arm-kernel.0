From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jan 2014 13:42:09 +0100
Subject: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
In-Reply-To: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdb2GvHAa9kF5KXWMiTDnyepziGmjqrCcgB1B7e0iHVKXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 10:25 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This passes the errata fix using a GPIO to control the RTS pin
> on one of the AT91 chips to use gpiolib instead of the
> AT91-specific interfaces. Also remove the reliance on
> compile-time #defines and the cpu_* check and rely on the
> platform passing down the proper GPIO pin through platform
> data.
>
> This is a prerequisite for getting rid of the local GPIO
> implementation in the AT91 platform and move toward
> multiplatform.
>
> The patch also adds device tree support for getting the
> RTS GPIO pin from the device tree on DT boot paths.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:

Hi Nicolas, I don't see this patch in linux-next, where did it
get stuck? Something I can help with? Greg has ACKed it
and all I think ...

Yours,
Linus Walleij

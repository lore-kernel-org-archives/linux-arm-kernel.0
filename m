From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Nov 2014 15:22:10 +0100
Subject: [PATCH v3] gpio: mxs: implement get_direction callback
In-Reply-To: <1416387322-17320-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1416387322-17320-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <CACRpkdZDCap5s8UvnYd1zf9hc7szQNfwdq+sv9BpFgsd-8_2mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 9:55 AM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:

> gpiolib's gpiod_get_direction() function returns the EINVAL error
> if .get_direction callback is not defined.
> The patch implements the callback for mxs chip which is useful
> for debugging.
>
> Inspired by arch/arm/mach-at91/gpio.c
>
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

This v3 version applied with Alexandre's ACK.

Yours,
Linus Walleij

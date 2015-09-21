From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 11:50:48 -0700
Subject: [PATCH v2 0/7] New Atmel PIO4 pinctrl/gpio driver
In-Reply-To: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkdYLbifY9VJK0FFf7xXdMJWstdGP=h5ApBMRyRXZHPDUaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 8:36 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> The Atmel PIO4 controller has been introduced with SAMA5D2 chip family. This
> drivers manages both pinmux/pinconf and gpio stuff. It is inspired by Mediatek
> pinctrl driver.
>
> Changes from v1:
> - remove some unneeded gpio specific ops (gpio_request, gpio_free,
>   gpio_request_enable, gpio_disable_free and gpio_set_direction).
> - code styling fixes.
> - add sama5d2 pin description and device pin muxing.

Looks Good To Me, and has Sascha's ACKs, so merged patches
1, 2, 3, 4 to the pinctrl tree. Please merge the AT91 DT things into
the AT91 tree.

Yours,
Linus Walleij

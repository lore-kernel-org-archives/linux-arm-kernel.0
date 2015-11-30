From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 09:29:55 +0100
Subject: [PATCH] pinctrl: bcm2835: Fix initial value for direction_output
In-Reply-To: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
References: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CACRpkdbZicosnYnp6ZxqvOhLdyuTJTHv2gYR0spWoGMzbToYOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 1:32 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Currently the provided initial value for bcm2835_gpio_direction_output
> has no effect. So fix this issue by changing the value before
> changing the GPIO direction. As a result we need to move the function below
> bcm2835_gpio_set.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> CC: Martin Sperl <kernel@martin.sperl.org>
> CC: Stephen Warren <swarren@wwwdotorg.org>

Waiting for Stephen's ACK on this.

Yours,
Linus Walleij

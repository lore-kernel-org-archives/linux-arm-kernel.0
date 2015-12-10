From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 19:07:21 +0100
Subject: [PATCH] pinctrl: bcm2835: Fix initial value for direction_output
In-Reply-To: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
References: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CACRpkdYO50aSra3gAzpBwBd0aQPA_aiC3t2rVHDUuXWmDQr=eg@mail.gmail.com>
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

Patch applied for fixes.

Yours,
Linus Walleij

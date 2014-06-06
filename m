From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 6 Jun 2014 14:10:43 +0900
Subject: [PATCH 0/4] <mach/gpio.h> purge
In-Reply-To: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
References: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAAVeFuKJE1pCtogU3BrkQHSTQyKOvo_u06Mmdioqu1_+9Nq2nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 4, 2014 at 10:33 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> After deleting <mach/gpio.h> from the AT91 only S5P remains.
> This patch set fixes up S5P and then removes NEED_MACH_GPIO_H
> permanently removing any references to <mach/gpio.h> from the
> ARM kernel. Do a small cleanout of a dangling reference to
> ARM_GPIOLIB_COMPLEX at the same time.

Good riddance indeed!

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

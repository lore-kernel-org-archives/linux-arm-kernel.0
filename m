From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 13:50:50 +0100
Subject: [PATCH v5 3/5] gpio: raspberrypi-exp: Driver for RPi3 GPIO
 expander via mailbox service
In-Reply-To: <8c34f287ee72b340fa9d693aa0e304b25541c74c.1519128054.git.baruch@tkos.co.il>
References: <cover.1519128054.git.baruch@tkos.co.il>
 <8c34f287ee72b340fa9d693aa0e304b25541c74c.1519128054.git.baruch@tkos.co.il>
Message-ID: <CACRpkdbJyS6K_JKTVRkQjj9AhKO0UegrAt2o2zeQkJCGBLgTHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 1:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:

> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
>
> Pi3 and Compute Module 3 have a GPIO expander that the
> VPU communicates with.
> There is a mailbox service that now allows control of this
> expander, so add a kernel driver that can make use of it.
>
> Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v5:
>   * Use the parent node to find the firmware

This v5 version applied to the GPIO tree for v4.17.

Yours,
Linus Walleij

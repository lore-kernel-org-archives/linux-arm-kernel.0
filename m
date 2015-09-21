From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 14:41:37 -0700
Subject: [PATCH v2 1/3] gpio: Use __gpiod_request directly
In-Reply-To: <1440920686-6892-2-git-send-email-mpa@pengutronix.de>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdbSMZxBafCnZ5VYd+k=_4gVob6Xu1kOdvhuO0GyV1M+dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 30, 2015 at 12:44 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> There is no reason to find out chip and hwnum to use to request a gpio
> and get another gpio descriptor. We already have the descriptor we want
> to use so we can directly use it.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Patch applied with Uwe's ACK.

Yours,
Linus Walleij

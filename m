From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Jun 2014 09:31:43 +0200
Subject: [PATCH v2] pinctrl: hide CONFIG_PINMUX and CONFIG_PINCONF
In-Reply-To: <1401782556-5210-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1401782556-5210-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdaVxSMHAQ5q=Z3cC5cQRUwXx-bus7XQFjuGqOW1+R4Dtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 3, 2014 at 10:02 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> These symbols are supposed to be selected by the drivers actually needing
> them. The only situation where it would make sense to enable them without a
> driver selecting them is when an out-of-tree pinctrl driver is used or
> for compile testing.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v1:
>   - allow enabling with COMPILE_TEST

Had some mixed feelings and back-and-forth about this patch
(I like the visual feedback in menuconfig) but eventually decided
that simplicity is better so applied the patch (for v3.17)

Yours,
Linus Walleij

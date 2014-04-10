From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 18:15:45 +0200
Subject: [PATCH] pinctrl: msm8x74: make Kconfig dependency more strict
In-Reply-To: <1396383959-7445-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1396383959-7445-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdanppJQaJz-koSfM7P=CibZ91ycnhF5Nv+b7PuW0R=bpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 1, 2014 at 10:25 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> This driver is only useful on MSM8x74, so let the driver depend on
> ARCH_QCOM but allow compile coverage testing.
> The main benefit is that the driver isn't available to be selected for
> machines that don't have the matching hardware.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Bj?rn is not protesting so patch applied!

Yours,
Linus Walleij

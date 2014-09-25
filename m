From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Sep 2014 09:54:05 +0200
Subject: [PATCH] pinctrl: bcm281xx: make Kconfig dependency more strict
In-Reply-To: <1411546524-13345-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1411546524-13345-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdaiirdTYZhQyChModLeAOizhM4ZwU=VG7cGAEqtALz7KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 10:15 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> This driver is only useful on BCM281xx, so let the driver depend on
> ARCH_BCM_MOBILE but allow compile coverage testing.
> The main benefit is that the driver isn't available to be selected for
> machines that don't have the matching hardware.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> This patch was sent earlier when the Kconfig symbol was still named
> "PINCTRL_CAPRI":
>
>         Date: Tue,  1 Apr 2014 22:10:21 +0200
>         Subject: [PATCH] pinctrl: capri: make Kconfig dependency more strict
>         Message-Id: <1396383021-2295-1-git-send-email-u.kleine-koenig@pengutronix.de>
>
> and got a
>
>         Reviewed-by: Sherman Yin <syin@broadcom.com>
>
> back then.

Patch applied.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 18:55:02 +0200
Subject: [PATCH] pinctrl: capri: make Kconfig dependency more strict
In-Reply-To: <1396383021-2295-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1396383021-2295-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdbqgqeJ2YDN+gsMfByR32D_wFOjPX-u7h2DhAYcLsnwwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 1, 2014 at 10:10 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> This driver is only useful on BCM281xx, so let the driver depend on
> ARCH_BCM_MOBILE but allow compile coverage testing.
> The main benefit is that the driver isn't available to be selected for
> machines that don't have the matching hardware.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Sherman is renaming this driver so this patch does not apply.

Please resubmit after the rename is upstream or something.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jul 2012 15:46:09 +0200
Subject: [PATCH] gpio/mxc: make irqs work for fsl,imx21-gpio devices
In-Reply-To: <1338976163-23001-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1338976163-23001-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdYY4sEah7hb9=N7y2CgC45Tp4nc4vrvTYq2Zje5aLuayQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 6, 2012 at 11:49 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> The chained handler was set for the platform device with id == 0.
> When the gpio devices are instantiated by a device tree, all have id ==
> -1 and so the handler was unset resulting in unusable gpio irqs on
> i.MX21 and i.MX27 (when using oftree).
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied.

> I'm not sure this is material for stable because it never worked before.

Why take a chance. It goes to stable.

I'll have to explain to Torvalds why this is coming late.

Yours,
Linus Walleij

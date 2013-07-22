From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Jul 2013 16:00:45 +0800
Subject: [PATCH] gpio/mxc: add chained_irq_enter/exit() to
 mx2_gpio_irq_handler
In-Reply-To: <1374152286-12955-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1374152286-12955-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130722080043.GD20271@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 02:58:06PM +0200, Uwe Kleine-K?nig wrote:
> Similar to commit
> 
> 	0e44b6e (gpio/mxc: add chained_irq_enter/exit() to mx3_gpio_irq_handler())
> 
> . It doesn't seem to be critical to make the irqs work, but still it is
> more correct.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

You may need to send the patch to Linus Walleij <linus.walleij@linaro.org>,
who seems to be collecting GPIO drive changes recently.

Shawn

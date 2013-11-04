From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Nov 2013 21:44:58 +0800
Subject: [PATCH] ARM: imx: drop support for irq priorisation
In-Reply-To: <1383553022-6983-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1383553022-6983-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131104134454.GB11031@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 09:17:02AM +0100, Uwe Kleine-K?nig wrote:
> The code for irq priorisation support doesn't have any in-tree users and
> the Kconfig description does wrong promises because nowadays irq
> handlers are called with irqs disabled, so no high prioritized irq can
> interrupt a lower prioritized handler.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.

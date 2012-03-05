From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 10:23:11 -0800
Subject: [PATCH] RM: OMAP4: board-4430sdp: don't initialize value that
 is never used
In-Reply-To: <1328823034-9668-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1328823034-9668-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120305182311.GD12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [120209 13:00]:
> sdp4430_spi_board_info.irq was initialized to ETH_KS8851_IRQ and in
> omap_4430sdp_init() overwritten with gpio_to_irq(ETH_KS8851_IRQ) before
> sdp4430_spi_board_info was registered. This is a bit confusing, so
> better don't initialize .irq and document that it is set later.

Thanks applying into board branch.

Regards,

Tony

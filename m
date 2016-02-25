From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Feb 2016 15:47:18 +0100
Subject: [PATCH 09/50] pinctrl: imx: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-10-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-10-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456411638.3268.14.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 24.02.2016, 18:45 +0530 schrieb Laxman Dewangan:
> Use devm_pinctrl_register() for pin control registration and remove
> need of .remove callback.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Adrian Alonso <aalonso@freescale.com>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
[...]

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

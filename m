From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 18 Jul 2013 20:06:04 +0800
Subject: [PATCH v10] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
References: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130718120600.GD16328@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 11:26:26AM +0200, Philipp Zabel wrote:
> This driver implements a reset controller device that toggle a gpio
> connected to a reset pin of a peripheral IC. The delay between assertion
> and de-assertion of the reset signal can be configured via device tree.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Tested-by: Shawn Guo <shawn.guo@linaro.org>

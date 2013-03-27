From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Mar 2013 20:10:26 +0800
Subject: [PATCH v5 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1364231189-12497-9-git-send-email-p.zabel@pengutronix.de>
References: <1364231189-12497-1-git-send-email-p.zabel@pengutronix.de>
 <1364231189-12497-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130327121024.GC2674@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:06:29PM +0100, Philipp Zabel wrote:
> This driver implements a reset controller device that toggles gpios
> connected to reset pins of peripheral ICs. The delay between assertion
> and de-assertion of the reset signal can be configured.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

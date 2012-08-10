From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Aug 2012 11:12:53 +0800
Subject: [PATCH] ARM: imx/imx31-dt: drop selecting USE_OF
In-Reply-To: <1344519333-6446-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1344519333-6446-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120810031251.GE19617@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 03:35:33PM +0200, Uwe Kleine-K?nig wrote:
> since commit
> 	3e62af8 (ARM: imx: select USE_OF)
> ARM_MXC already selects USE_OF, so there is no need to repeat it for
> MACH_IMX31_DT
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.

-- 
Regards,
Shawn

From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 14 Jun 2011 19:51:00 +0800
Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: remove "WP" from flag
	ESDHC_FLAG_GPIO_FOR_CD_WP
In-Reply-To: <20110614092812.GC5043@pengutronix.de>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<1307702572-22066-4-git-send-email-shawn.guo@linaro.org>
	<20110614092812.GC5043@pengutronix.de>
Message-ID: <20110614115059.GE30295@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 11:28:13AM +0200, Wolfram Sang wrote:
> On Fri, Jun 10, 2011 at 06:42:51PM +0800, Shawn Guo wrote:
> > The use of flag ESDHC_FLAG_GPIO_FOR_CD_WP is all CD related.  It does
> > not necessarily need to bother WP in the flag name.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I'd just squash it into the next one?
> 
I'd like to have this patch to give the exact meaning of the flag,
and then the following patch removes the flag with proper CD only
case handling.

-- 
Regards,
Shawn

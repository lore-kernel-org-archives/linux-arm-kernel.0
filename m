From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 14 Jun 2011 11:28:13 +0200
Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: remove "WP" from flag
	ESDHC_FLAG_GPIO_FOR_CD_WP
In-Reply-To: <1307702572-22066-4-git-send-email-shawn.guo@linaro.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<1307702572-22066-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110614092812.GC5043@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 06:42:51PM +0800, Shawn Guo wrote:
> The use of flag ESDHC_FLAG_GPIO_FOR_CD_WP is all CD related.  It does
> not necessarily need to bother WP in the flag name.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I'd just squash it into the next one?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110614/b61e9c87/attachment.sig>

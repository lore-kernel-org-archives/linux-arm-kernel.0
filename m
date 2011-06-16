From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 16 Jun 2011 14:10:22 +0200
Subject: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
	write_protect support for mx5
In-Reply-To: <1308136522-3403-5-git-send-email-shawn.guo@linaro.org>
References: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
	<1308136522-3403-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110616121022.GC23579@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 07:15:22PM +0800, Shawn Guo wrote:
> The patch extends card_detect and write_protect support to get mx5
> family and more scenarios supported.  The changes include:
> 
>  * Turn platform_data from optional to mandatory
>  * Add cd_types and wp_types into platform_data to cover more use
>    cases
>  * Remove the use of flag ESDHC_FLAG_GPIO_FOR_CD
>  * Adjust some machine codes to adopt the platform_data changes
> 
> With this patch, card_detect and write_protect gets supported on
> mx5 based platforms.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Looks like right direction to me, so far; some testers would be good,
though.

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110616/b8d30372/attachment.sig>

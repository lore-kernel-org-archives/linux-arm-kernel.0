From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 21 Mar 2011 14:06:30 +0100
Subject: [PATCH V7 3/4] mmc: sdhci-esdhc: make the writel/readl as the
	general APIs
In-Reply-To: <1300684936-8218-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300684936-8218-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1300684936-8218-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110321130630.GF9686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 01:22:15PM +0800, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110321/5fc91d21/attachment-0001.sig>

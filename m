From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 25 Mar 2011 09:53:29 +0100
Subject: [PATCH V8 3/4] mmc: sdhci-esdhc: make the writel/readl as the
	general APIs
In-Reply-To: <1301024346-2232-3-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1301024346-2232-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1301024346-2232-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110325085329.GA3302@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2011 at 11:39:05AM +0800, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---

Please provide something like "changes since last time" _below_ this
dashed line "---" next time. Or use --cover-letter to introduce the
changes.

Other than that

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de> 

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110325/e576ce0d/attachment.sig>

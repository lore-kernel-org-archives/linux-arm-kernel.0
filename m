From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 18 Mar 2011 14:52:48 +0100
Subject: [PATCH V7 3/4] mmc: sdhci-esdhc: make the writel/readl as the
	general APIs
In-Reply-To: <1300442217-1060-3-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300442217-1060-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1300442217-1060-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110318135248.GF2155@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 05:56:56PM +0800, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>

You addressed 2 out of 3 comments nicely. But you still cast the void*
back and forth which is unnecessary. After that, I think we are finally
done.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110318/4684863e/attachment-0001.sig>

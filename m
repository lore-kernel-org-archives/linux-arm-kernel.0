From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 19 Oct 2010 17:07:43 +0200
Subject: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
In-Reply-To: <1287492541-3060-1-git-send-email-eric@eukrea.com>
References: <1287492541-3060-1-git-send-email-eric@eukrea.com>
Message-ID: <20101019150743.GA26784@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 02:49:01PM +0200, Eric B?nard wrote:
> this patch fix timeout problems on i.MX51 as suggested by
> Richard Zhu.
> more tests are needed to check if this quirk can be removed
> for i.MX25 and 35.

Didn't you have such boards?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/92a987f0/attachment.sig>

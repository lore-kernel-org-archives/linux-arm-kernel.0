From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 May 2011 11:40:46 +0200
Subject: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get
	them self registered
In-Reply-To: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110519094046.GA2219@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> Changes since v1:
>  * Rebase on cjb's mmc-next tree

Is it maybe possible that you get access to
http://opensource.freescale.com/git or another machine? A branch to pull
from would be more convenient, because the series does not apply to
mmc-next anymore, so an extra step to go "back in time" is needed.

(minor) When applying I got:

Applying: mmc: sdhci: make sdhci-pltfm device drivers self registered
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:384: trailing whitespace.
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:817: space before tab in indent.
 	struct tegra_sdhci_platform_data *plat;
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:867: trailing whitespace.

Applying: sdhci: rename sdhci-esdhc-imx.c to sdhci-esdhc.c
/home/wsa/Kernel/linux-2.6/.git/rebase-apply/patch:780: trailing whitespace.

See later comments for further issues.

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110519/0ecfafb4/attachment.sig>

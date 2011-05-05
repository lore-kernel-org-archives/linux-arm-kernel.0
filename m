From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 5 May 2011 18:20:52 +0400
Subject: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
In-Reply-To: <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110505142051.GA17915@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 09:22:56PM +0800, Shawn Guo wrote:
> This patch is to consolidate SDHCI driver for Freescale eSDHC
> controller found on both MPCxxx and i.MX platforms.  It merges
> sdhci-of-esdhc.c into sdhci-esdhc.c, so that the same pair of
> .probe/.remove hook works with eSDHC for two platforms.
> 
> As the results, sdhci-of-esdhc.c and sdhci-esdhc.h are removed, and
> header esdhc.h containing the definition of esdhc_platform_data is
> put into the public folder.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I'm not sure if that makes sense to merge these two.
I'd rather vote for renaming sdhci-of-esdhc to sdhci-esdhc-mpc. :-)

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com

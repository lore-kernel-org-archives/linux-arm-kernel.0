From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 5 May 2011 18:13:00 +0400
Subject: [PATCH v2 6/7] mmc: sdhci: merge two sdhci-pltfm.h into one
In-Reply-To: <1304601778-13837-7-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110505141300.GA17734@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 09:22:57PM +0800, Shawn Guo wrote:
> The structure sdhci_pltfm_data is not necessarily to be in a public
> header like include/linux/mmc/sdhci-pltfm.h, so the patch moves it
> into drivers/mmc/host/sdhci-pltfm.h and eliminates the former one.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 5 May 2011 18:23:52 +0400
Subject: [PATCH v2 2/7] mmc: sdhci: eliminate sdhci_of_host and
	sdhci_of_data
In-Reply-To: <1304601778-13837-3-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110505142352.GB17915@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 09:22:53PM +0800, Shawn Guo wrote:
> The patch migrates the use of sdhci_of_host and sdhci_of_data to
> sdhci_pltfm_host and sdhci_pltfm_data, so that the former pair can
> be eliminated.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com

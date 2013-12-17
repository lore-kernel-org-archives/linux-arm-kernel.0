From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 22:30:28 +0800
Subject: [PATCH v2 0/5] mmc: sdhci: a few fixes on timeout and
 max_discard_to
In-Reply-To: <1387268191-19859-1-git-send-email-b29396@freescale.com>
References: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Message-ID: <20131217143025.GX6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 04:16:26PM +0800, Dong Aisheng wrote:
> Dong Aisheng (5):
>   mmc: sdhci: add platfrom get_max_timeout_count hook
>   mmc: sdhci-esdhc-imx: fix incorrect max_discard_to for uSDHC
>   mmc: sdhci: add platform set_timeout hook
>   mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
>   mmc: sdhci: calculate max_discard_to dynamically for
>     SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK

For all,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

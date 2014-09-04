From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 4 Sep 2014 13:07:32 +0800
Subject: [PATCH 0/7] mmc: sdhci/imx: a few clean up and fixes
In-Reply-To: <1409745903-26550-1-git-send-email-b29396@freescale.com>
References: <1409745903-26550-1-git-send-email-b29396@freescale.com>
Message-ID: <20140904050730.GA18688@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 08:04:56PM +0800, Dong Aisheng wrote:
> A few clean up and fixes.
> 
> Dong Aisheng (7):
>   mmc: sdhci-esdhc-imx: remove duplicated lines
>   mmc: sdhci-esdhc-imx: usdhc does not have missing card interrupt
>     issue
>   mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
>   mmc: sdhci: do not enable card detect interrupt for gpio cd type
>   mmc: sdhci: do not enable card cd wakeup for gpio case
>   mmc: sdhci-esdhc-imx: add imx6sx support
>   mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl

For all 7,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

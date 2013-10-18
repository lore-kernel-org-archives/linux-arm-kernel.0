From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Oct 2013 19:46:01 +0800
Subject: [PATCH v2 0/8] mmc: sdhci-esdhc-imx: add std tuning for mx6sl
 and DDR mode support
In-Reply-To: <1382093661-4074-1-git-send-email-b29396@freescale.com>
References: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Message-ID: <20131018114553.GE6043@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 06:54:13PM +0800, Dong Aisheng wrote:
> ChangeLog:
> v1->v2:
>  - Only a few minor changes on patch 1 and 5 based on comments from Shawn
>    while other patches have no change.
>  - rebase on Shawn's patch series
>    [PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
> 
> Dong Aisheng (8):
>   mmc: sdhci-esdhc-imx: add std tuning support for mx6sl
>   mmc: sdhci-esdhc-imx: fix reading cap_1 register value for mx6sl
>   mmc: sdhci: report error once the maximum tuning loops exhausted or
>     timeout
>   mmc: sdhci-esdhc-imx: add DDR mode support for mx6
>   mmc: sdhci-esdhc-imx: add delay line setting support
>   mmc: sdhci-esdhc-imx: enable SDR50 tuning for imx6q/dl
>   mmc: sdhci-esdhc-imx: add preset value quirk for mx6
>   mmc: sdhci: remove unneeded call when have preset value quirk

Other than 2 small comments I gave on patch #1 and #5, for the series:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

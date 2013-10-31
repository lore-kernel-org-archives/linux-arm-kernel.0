From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 15:04:45 +0800
Subject: [PATCH v2 0/6] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr
 not supported on sabresd issues
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Message-ID: <20131031070442.GD23549@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 10:09:47PM +0800, Dong Aisheng wrote:
> Dong Aisheng (6):
>   mmc: sdhci: clear auto cmd setting bits for no data cmds
>   mmc: sdhci-esdhc-imx: add SDHCI_TRANSFER_MODE read function
>   ARM: dts: sabresd: add usdhc4 support
>   mmc: sdhci-esdhc-imx: fix cpas over write issue
>   mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR for mx6
>   mmc: core: mmc DDR mode should not depend on UHS_DDR50

For the series:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

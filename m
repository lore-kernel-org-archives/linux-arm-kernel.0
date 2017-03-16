From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 16 Mar 2017 15:46:20 +0100
Subject: [PATCH 0/3] mmc: sdhci: remove unnecessary platform_set_drvdata()
 call
In-Reply-To: <20170310031733.812-1-jszhang@marvell.com>
References: <20170310031733.812-1-jszhang@marvell.com>
Message-ID: <CAPDyKFrofV9TW9iQ7Cago1uFari=HeHpVNw6Odkgvf3nC_6u=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 March 2017 at 04:17, Jisheng Zhang <jszhang@marvell.com> wrote:
> sdhci_pltfm_init() has already set the platform drvdata for us, so its
> users doesn't need to set the drvdata again. These patches clean up all
> unnecessary platform_set_drvdata() call.
>
> Jisheng Zhang (3):
>   mmc: sdhci-pxav3: remove unnecessary platform_set_drvdata() call
>   mmc: sdhci-pxav2: remove unnecessary platform_set_drvdata() call
>   mmc: sdhci-st: remove unnecessary platform_set_drvdata() call
>
>  drivers/mmc/host/sdhci-pxav2.c | 2 --
>  drivers/mmc/host/sdhci-pxav3.c | 2 --
>  drivers/mmc/host/sdhci-st.c    | 2 --
>  3 files changed, 6 deletions(-)
>
> --
> 2.11.0
>

Thanks, applied for next!

Kind regards
Uffe

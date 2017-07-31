From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 31 Jul 2017 10:52:50 +0200
Subject: [PATCH 00/12] constify mmc_host_ops structures
In-Reply-To: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CAPDyKFpPRNAb1s4PUnkg0iFUg-Y5J+T_5TAzxLL-4SVSSVY4MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2017 at 07:59, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> The mmc_host_ops structure is only stored in the ops field of an
> mmc_host structure, which is declared as const.  Thus the mmc_host_ops
> structure itself can be const.
>
> Done with the help of Coccinelle.
>
> ---
>
>  drivers/mmc/host/bcm2835.c     |    2 +-
>  drivers/mmc/host/davinci_mmc.c |    2 +-
>  drivers/mmc/host/moxart-mmc.c  |    2 +-
>  drivers/mmc/host/mtk-sd.c      |    2 +-
>  drivers/mmc/host/s3cmci.c      |    2 +-
>  drivers/mmc/host/sdricoh_cs.c  |    2 +-
>  drivers/mmc/host/sh_mmcif.c    |    2 +-
>  drivers/mmc/host/sunxi-mmc.c   |    2 +-
>  drivers/mmc/host/toshsd.c      |    2 +-
>  drivers/mmc/host/usdhi6rol0.c  |    2 +-
>  drivers/mmc/host/vub300.c      |    2 +-
>  drivers/mmc/host/wmt-sdmmc.c   |    2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)


Thanks, applied for next!

Kind regards
Uffe

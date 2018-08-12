From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 12 Aug 2018 15:24:35 +0200
Subject: [PATCH v9 4/4] dmaengine: fsl-edma: add ColdFire mcf5441x edma
 support
In-Reply-To: <20180811112649.20752-4-angelo@sysam.it>
References: <20180811112649.20752-1-angelo@sysam.it>
 <20180811112649.20752-4-angelo@sysam.it>
Message-ID: <CAJKOXPeb9pYssvhYFnRMTn4r8vK4AtR8TQCR45po9=0491z44g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 August 2018 at 13:26, Angelo Dureghello <angelo@sysam.it> wrote:
> This patch adds support for ColdFire mcf5441x-family edma
> module.
>
> The ColdFire edma module is slightly different from fsl-edma,
> so a new driver is added. But most of the code is common
> between fsl-edma and mcf-edma so it has been collected into a
> separate common module fsl-edma-common (patch 1/3).
>
> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> ---
> Changes for v8:
> - patch rewritten from scratch, this patch (3/3) has just been added.
>
> Changes for v9:
> - add compile test for Kconfig,
> - fix include guard.
> ---
>  drivers/dma/Kconfig                        |  11 +
>  drivers/dma/Makefile                       |   1 +
>  drivers/dma/fsl-edma-common.c              |  24 +-
>  drivers/dma/mcf-edma.c                     | 315 +++++++++++++++++++++
>  include/linux/platform_data/dma-mcf-edma.h |  38 +++
>  5 files changed, 385 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/dma/mcf-edma.c
>  create mode 100644 include/linux/platform_data/dma-mcf-edma.h

Here and in other patches I already gave you my Tested-by tags...

Best regards,
Krzysztof

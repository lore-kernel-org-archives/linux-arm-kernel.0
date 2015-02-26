From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 26 Feb 2015 09:28:06 -0800
Subject: [PATCH 0/4] Add support for IPROC SDHCI controller
In-Reply-To: <1423526791-29453-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1423526791-29453-1-git-send-email-sbranden@broadcom.com>
Message-ID: <54EF57A6.8070607@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

I have not heard any more feedback on this patchset.  Is it in your 
queue to review or merge into your tree?

Thanks,
  Scott

On 15-02-09 04:06 PM, Scott Branden wrote:
> This series of patchsets contains the IPROC SDHCI driver used
> in a series of Broadcom SoCs
> Quirks are also added to support this controller.
>
> Corneliu Doban (1):
>    mmc: sdhci: do not set AUTO_CMD12 for multi-block CMD53
>
> Scott Branden (3):
>    mmc: sdhci: add quirk for ACMD23 broken
>    mmc: sdhci-iproc: add IPROC SDHCI driver
>    mmc: sdhci-iproc: add device tree bindings
>
>   .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  23 ++
>   drivers/mmc/host/Kconfig                           |  14 ++
>   drivers/mmc/host/Makefile                          |   1 +
>   drivers/mmc/host/sdhci-iproc.c                     | 241 +++++++++++++++++++++
>   drivers/mmc/host/sdhci.c                           |   7 +-
>   include/linux/mmc/sdhci.h                          |   2 +
>   6 files changed, 286 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>   create mode 100644 drivers/mmc/host/sdhci-iproc.c
>

From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 29 Jul 2015 17:10:28 +0800
Subject: [PATCH v3 0/6] mmc: imx: a few fixes and new feature
In-Reply-To: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <20150729091027.GC16916@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 05:03:51PM +0800, Haibo Chen wrote:
> Changes for v3:
> -Add property describe in binding doc.
> 
> Haibo Chen (6):
>   mmc: sdhci-esdhc-imx: add imx7d support and support HS400
>   mmc: sdhci-esdhc-imx: add tuning-step seting support
>   ARM: dts: imx7d-sdb: add eMMC5.0 support
>   mmc: sdhci-esdhc-imx: add compatible string in bingding doc
>   mmc: sdhci-esdhc-imx: config watermark level and burst length
>   mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
> 

Hi Haibo,

I'm a little busy these days.
Will help review it ASAP, maybe can do it tomorrow.

Regards
Dong Aisheng

>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  2 +
>  arch/arm/boot/dts/imx7d-sdb.dts                    | 13 +++
>  drivers/mmc/host/sdhci-esdhc-imx.c                 | 97 +++++++++++++++++++++-
>  include/linux/platform_data/mmc-esdhc-imx.h        |  1 +
>  4 files changed, 112 insertions(+), 1 deletion(-)
> 
> -- 
> 1.9.1
> 

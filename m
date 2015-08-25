From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 25 Aug 2015 14:06:05 +0200
Subject: [PATCH v6 0/6] mmc: imx: a few fixes and new feature
In-Reply-To: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
References: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <CAPDyKFriWeJTsymd+Ha0ZY+UWjpbEdKMwZgw1hA2zZhw5khPaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 August 2015 at 13:38, Haibo Chen <haibo.chen@freescale.com> wrote:
> Changes for v6:
> -remove duplicate code in esdhc_set_uhs_signaling().
> -fix a typo for patch-2.
> -make commit log of patch-3 more specific.
>
> Haibo Chen (6):
>   mmc: sdhci-esdhc-imx: add imx7d support and support HS400
>   mmc: sdhci-esdhc-imx: add tuning-step setting support
>   mmc: sdhci-esdhc-imx: add imx7d support in bingding doc
>   ARM: dts: imx7d-sdb: add eMMC5.0 support
>   mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
>   mmc: sdhci-esdhc-imx: change default watermark level and burst length
>
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
>  arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
>  drivers/mmc/host/sdhci-esdhc-imx.c                 | 114 ++++++++++++++++++++-
>  include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
>  4 files changed, 130 insertions(+), 4 deletions(-)
>
> --
> 1.9.1
>

I have applied this for next - except patch4 as it needs and ack from
the IMX SOC maintainer, or it may be better to take that patch through
ARM soc...

Regarding patch3, which document the new bindings and the compatible
string, I moved this to be the first patch and fixed the spelling of
the commit message header.

Thanks!

Kind regards
Uffe

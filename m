From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 18 Nov 2010 10:30:00 +0900
Subject: [PATCH] ASoC: add codec support for mini6410 and real6410 boards
In-Reply-To: <20101117202131.3540.44215.stgit@localhost.localdomain>
References: <20101117202131.3540.44215.stgit@localhost.localdomain>
Message-ID: <AANLkTim1Qwzx3=q3tQmXJNRmb4YkbNJFqjv_JA0MG31z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 5:21 AM, Paulius Zaleckas
<paulius.zaleckas@gmail.com> wrote:
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---
>
> ?sound/soc/s3c24xx/Kconfig | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
> index 8a6b53c..b1fcbd3 100644
> --- a/sound/soc/s3c24xx/Kconfig
> +++ b/sound/soc/s3c24xx/Kconfig
> @@ -132,7 +132,7 @@ config SND_S3C24XX_SOC_RX1950_UDA1380
>
> ?config SND_SOC_SMDK_WM9713
> ? ? ? ?tristate "SoC AC97 Audio support for SMDK with WM9713"
> - ? ? ? depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
> + ? ? ? depends on SND_S3C24XX_SOC && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_MINI6410 || MACH_REAL6410)
> ? ? ? ?select SND_SOC_WM9713
> ? ? ? ?select SND_S3C_SOC_AC97
> ? ? ? ?help

Acked-by: Jassi Brar <jassi.brar@samsung.com>

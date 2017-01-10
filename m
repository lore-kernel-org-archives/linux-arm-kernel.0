From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Jan 2017 14:57:19 +0530
Subject: [RESEND 3/3] ARM: davinci_all_defconfig: enable iio and ADS7950
In-Reply-To: <1483978300-403-4-git-send-email-david@lechnology.com>
References: <1483978300-403-1-git-send-email-david@lechnology.com>
 <1483978300-403-4-git-send-email-david@lechnology.com>
Message-ID: <03501962-eb4a-6936-15dd-ed59c73f9cd9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 January 2017 09:41 PM, David Lechner wrote:
> This enables the iio subsystem and the TI ADS7950 driver. This is used by
> LEGO MINDSTORMS EV3, which has an ADS7957 chip.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/configs/davinci_all_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
> index 2b1967a..a899876 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -200,6 +200,13 @@ CONFIG_TI_EDMA=y
>  CONFIG_MEMORY=y
>  CONFIG_TI_AEMIF=m
>  CONFIG_DA8XX_DDRCTL=y
> +CONFIG_IIO=m
> +CONFIG_IIO_BUFFER_CB=m
> +CONFIG_IIO_SW_DEVICE=m
> +CONFIG_IIO_SW_TRIGGER=m
> +CONFIG_TI_ADS7950=m
> +CONFIG_IIO_HRTIMER_TRIGGER=m
> +CONFIG_IIO_SYSFS_TRIGGER=m

Hmm, there are some other comments I gave on the previous version I
don't see addressed. Can you please fix those or respond to those comments?

Thanks,
Sekhar

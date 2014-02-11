From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Feb 2014 12:31:45 +0900
Subject: [PATCH 22/28] Remove S3C24XX_GPIO_EXTRA128
In-Reply-To: <1391971686-9517-23-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-23-git-send-email-richard@nod.at>
Message-ID: <52F999A1.1070709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/14 03:48, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.
>
> Signed-off-by: Richard Weinberger<richard@nod.at>
> ---
>   arch/arm/mach-s3c24xx/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 1c67f04..bb1fa603 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -561,7 +561,6 @@ config MACH_OSIRIS
>   	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
>   	select S3C2440_XTAL_12000000
>   	select S3C24XX_DCLK
> -	select S3C24XX_GPIO_EXTRA128
>   	select S3C24XX_SIMTEC_PM if PM
>   	select S3C_DEV_NAND
>   	select S3C_DEV_USB_HOST

OK good, but I will squash this with 13th for mach-s3c24xx/Kconfig when 
I apply.

Thanks,
Kukjin

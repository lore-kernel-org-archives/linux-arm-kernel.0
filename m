From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Feb 2014 12:29:11 +0900
Subject: [PATCH 13/28] Remove S3C24XX_GPIO_EXTRA64
In-Reply-To: <1391971686-9517-14-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-14-git-send-email-richard@nod.at>
Message-ID: <52F99907.6010604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/14 03:47, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.
>
> Signed-off-by: Richard Weinberger<richard@nod.at>
> ---
>   arch/arm/mach-s3c24xx/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index d876431..1c67f04 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -521,7 +521,6 @@ config MACH_ANUBIS
>   	select HAVE_PATA_PLATFORM
>   	select S3C2440_XTAL_12000000
>   	select S3C24XX_DCLK
> -	select S3C24XX_GPIO_EXTRA64
>   	select S3C24XX_SIMTEC_PM if PM
>   	select S3C_DEV_USB_HOST
>   	help

OK, I will take this into samsung tree.

Thanks,
Kukjin

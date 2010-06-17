From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 17 Jun 2010 22:59:59 +0100
Subject: [PATCH] SMDK2416: Select MACH_SMDK, S3C_DEV_NAND, S3C_DEV_USB_HOST
In-Reply-To: <1276786221-29640-1-git-send-email-jekhor@gmail.com>
References: <1276786221-29640-1-git-send-email-jekhor@gmail.com>
Message-ID: <20100617215959.GF7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 05:50:21PM +0300, Yauhen Kharuzhy wrote:
> Enable compilation of platform devices and initialization code used in
> SMDK2416 board file.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-s3c2416/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> index 657e4fe..eafb0ed 100644
> --- a/arch/arm/mach-s3c2416/Kconfig
> +++ b/arch/arm/mach-s3c2416/Kconfig
> @@ -30,9 +30,12 @@ menu "S3C2416 Machines"
>  config MACH_SMDK2416
>  	bool "SMDK2416"
>  	select CPU_S3C2416
> +	select MACH_SMDK
>  	select S3C_DEV_FB
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC1
> +	select S3C_DEV_NAND
> +	select S3C_DEV_USB_HOST
>  	help
>  	  Say Y here if you are using an SMDK2416
>  
> -- 
> 1.6.6.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

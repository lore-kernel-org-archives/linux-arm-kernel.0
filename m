From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Oct 2010 19:56:19 +0900
Subject: [PATCH 2/2] ARM: S3C2416: Change S3C2416 NAND platform device name
In-Reply-To: <1279495911-17346-3-git-send-email-sbkim73@samsung.com>
References: <1279495911-17346-1-git-send-email-sbkim73@samsung.com>
	<1279495911-17346-3-git-send-email-sbkim73@samsung.com>
Message-ID: <048501cb6eb3$19f30770$4dd91650$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> From: Atul Dahiya <atul.dahiya@samsung.com>
> 
> This patch changes the platform device name from 's3c2416-nand' to
> 's3c2412-nand' so that S3C2416 can reuse the nand functionality
> available on S3C2412.
> 
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  arch/arm/mach-s3c2416/s3c2416.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-
> s3c2416/s3c2416.c
> index bfe674f..6468b6c 100644
> --- a/arch/arm/mach-s3c2416/s3c2416.c
> +++ b/arch/arm/mach-s3c2416/s3c2416.c
> @@ -100,7 +100,7 @@ void __init s3c2416_init_uarts(struct s3c2410_uartcfg
> *cfg, int no)
>  {
>  	s3c24xx_init_uartdevs("s3c2440-uart", s3c2410_uart_resources, cfg,
no);
> 
> -	s3c_nand_setname("s3c2416-nand");
> +	s3c_nand_setname("s3c2412-nand");
>  }
> 
>  /* s3c2416_map_io
> --
Ok...will apply.

Ben, if any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

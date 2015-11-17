From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 17 Nov 2015 10:25:00 +0000
Subject: [PATCH] MAINTAINERS: Atmel drivers: change NAND and ISI entries
In-Reply-To: <1447755695-18034-1-git-send-email-nicolas.ferre@atmel.com>
References: <1447755695-18034-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63678E9@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Nicolas Ferre [mailto:nicolas.ferre at atmel.com]
> Sent: 2015?11?17? 18:22
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org; Ferre, Nicolas; Desroches, Ludovic; Yang,
> Wenyou; Josh Wu
> Subject: [PATCH] MAINTAINERS: Atmel drivers: change NAND and ISI entries
> 
> Update Josh's entries about NAND and ISI drivers.
> Thanks for your work with Atmel Josh!
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: Josh Wu <rainyfeeling@outlook.com>
Acked-by: Wenyou Yang <wenyou.yang@atmel.com>

> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9caa4b28828..3c9d0d0ba0e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1931,7 +1931,7 @@ S:	Supported
>  F:	drivers/i2c/busses/i2c-at91.c
> 
>  ATMEL ISI DRIVER
> -M:	Josh Wu <josh.wu@atmel.com>
> +M:	Ludovic Desroches <ludovic.desroches@atmel.com>
>  L:	linux-media at vger.kernel.org
>  S:	Supported
>  F:	drivers/media/platform/soc_camera/atmel-isi.c
> @@ -1950,7 +1950,8 @@ S:	Supported
>  F:	drivers/net/ethernet/cadence/
> 
>  ATMEL NAND DRIVER
> -M:	Josh Wu <josh.wu@atmel.com>
> +M:	Wenyou Yang <wenyou.yang@atmel.com>
> +M:	Josh Wu <rainyfeeling@outlook.com>
>  L:	linux-mtd at lists.infradead.org
>  S:	Supported
>  F:	drivers/mtd/nand/atmel_nand*
> --
> 2.1.3


Best Regards,
Wenyou Yang

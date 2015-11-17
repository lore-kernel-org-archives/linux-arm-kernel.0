From: rainyfeeling@outlook.com (Josh Wu)
Date: Tue, 17 Nov 2015 21:27:13 +0800
Subject: [PATCH] MAINTAINERS: Atmel drivers: change NAND and ISI entries
In-Reply-To: <1447755695-18034-1-git-send-email-nicolas.ferre@atmel.com>
References: <1447755695-18034-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <BLU436-SMTP1165C4E12935990A9783E5EDB1D0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Nicolas

On 2015?11?17? 18:21, Nicolas Ferre wrote:
> Update Josh's entries about NAND and ISI drivers.
> Thanks for your work with Atmel Josh!
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: Josh Wu <rainyfeeling@outlook.com>
> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9caa4b28828..3c9d0d0ba0e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1931,7 +1931,7 @@ S:	Supported
>   F:	drivers/i2c/busses/i2c-at91.c
>   
>   ATMEL ISI DRIVER
> -M:	Josh Wu <josh.wu@atmel.com>
> +M:	Ludovic Desroches <ludovic.desroches@atmel.com>
>   L:	linux-media at vger.kernel.org
>   S:	Supported
>   F:	drivers/media/platform/soc_camera/atmel-isi.c
> @@ -1950,7 +1950,8 @@ S:	Supported
>   F:	drivers/net/ethernet/cadence/
>   
>   ATMEL NAND DRIVER
> -M:	Josh Wu <josh.wu@atmel.com>
> +M:	Wenyou Yang <wenyou.yang@atmel.com>
> +M:	Josh Wu <rainyfeeling@outlook.com>
>   L:	linux-mtd at lists.infradead.org
>   S:	Supported
>   F:	drivers/mtd/nand/atmel_nand*

Acked-by: Josh Wu <rainyfeeling@outlook.com>

Best Regards,
Josh Wu

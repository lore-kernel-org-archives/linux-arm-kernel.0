From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 2 Sep 2015 14:25:45 +0300
Subject: [PATCH] video: fbdev: atmel_lcdfb: remove useless include
In-Reply-To: <1439217114-12317-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439217114-12317-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55E6DCB9.2080204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/15 17:31, Alexandre Belloni wrote:
> Definitions from linux/platform_data/atmel.h are not used, remove the
> include.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index abadc490fa1f..a5006788647c 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -19,7 +19,6 @@
>  #include <linux/backlight.h>
>  #include <linux/gfp.h>
>  #include <linux/module.h>
> -#include <linux/platform_data/atmel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>

Thanks, queued for 4.3.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150902/1f3486fe/attachment.sig>

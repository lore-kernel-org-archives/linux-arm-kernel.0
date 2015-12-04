From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 4 Dec 2015 22:08:42 +0100
Subject: [PATCH 1/2] phy: berlin-usb: remove non-necessary header files
In-Reply-To: <1449237421-5552-2-git-send-email-jszhang@marvell.com>
References: <1449237421-5552-1-git-send-email-jszhang@marvell.com>
 <1449237421-5552-2-git-send-email-jszhang@marvell.com>
Message-ID: <20151204210842.GA7200@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 09:57:00PM +0800, Jisheng Zhang wrote:
> We don't need gpio related header files, so remove them.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  drivers/phy/phy-berlin-usb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/phy-berlin-usb.c
> index 797ba17..7bbb473 100644
> --- a/drivers/phy/phy-berlin-usb.c
> +++ b/drivers/phy/phy-berlin-usb.c
> @@ -9,11 +9,9 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> -#include <linux/gpio.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> -- 
> 2.6.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151204/91f484a2/attachment.sig>

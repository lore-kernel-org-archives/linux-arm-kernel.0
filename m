From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Apr 2014 09:55:39 -0500
Subject: [PATCH v2 01/18] usb: host: xhci-plat: Sort the headers in
 alphabetic order
In-Reply-To: <1398434836-18908-2-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140425145539.GB29632@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 04:06:59PM +0200, Gregory CLEMENT wrote:
> Sorting the headers in alphabetic order will help to reduce the conflict
> when adding new headers later.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Acked-by: Felipe Balbi <balbi@ti.com>

>  drivers/usb/host/xhci-plat.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 151901ce1ba9..f5351af4b2c5 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -11,11 +11,11 @@
>   * version 2 as published by the Free Software Foundation.
>   */
>  
> -#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/module.h>
> -#include <linux/slab.h>
>  #include <linux/of.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
>  
>  #include "xhci.h"
>  
> -- 
> 1.8.1.2
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/13344dad/attachment-0001.sig>

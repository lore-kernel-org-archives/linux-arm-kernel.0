From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jul 2014 08:45:02 -0500
Subject: [PATCH 2/9] usb: phy: am335x: group the #includes by subdirs
In-Reply-To: <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718134502.GB24914@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 11:31:23AM +0200, Lothar Wa?mann wrote:
> 

no commit log. Not a bug fix.

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/usb/phy/phy-am335x.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
> index b70e055..91c71ab 100644
> --- a/drivers/usb/phy/phy-am335x.c
> +++ b/drivers/usb/phy/phy-am335x.c
> @@ -1,13 +1,13 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/usb/otg.h>
> -#include <linux/usb/usb_phy_generic.h>
>  #include <linux/slab.h>
>  #include <linux/clk.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/usb_phy_generic.h>
>  
>  #include "am35x-phy-control.h"
>  #include "phy-generic.h"
> -- 
> 1.7.10.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/9b96c750/attachment.sig>

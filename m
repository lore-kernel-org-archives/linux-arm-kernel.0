From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 23 Jan 2017 17:04:04 +0800
Subject: [RESEND PATCH] usb: chipidea: delete an useless header include
In-Reply-To: <20170123070545.2714-1-jszhang@marvell.com>
References: <20170123070545.2714-1-jszhang@marvell.com>
Message-ID: <20170123090404.GA19373@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 03:05:45PM +0800, Jisheng Zhang wrote:
> <linux/phy.h> is for net phy drivers, we don't need it.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/usb/chipidea/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 3dbb4a21ab44..77078083e9fb 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -62,7 +62,6 @@
>  #include <linux/usb/chipidea.h>
>  #include <linux/usb/of.h>
>  #include <linux/of.h>
> -#include <linux/phy.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/usb/ehci_def.h>
>  

Applied, thanks.

-- 

Best Regards,
Peter Chen

From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 3 Nov 2016 17:26:49 +0530
Subject: [PATCH 3/3] usb: ohci-da8xx: rename driver to ohci-da8xx
In-Reply-To: <20161102124435.31777-4-ahaslam@baylibre.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
 <20161102124435.31777-4-ahaslam@baylibre.com>
Message-ID: <a1b45345-ef63-ad6a-a755-57881355049d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 November 2016 06:14 PM, Axel Haslam wrote:
> To be consistent on the usb driver for the davinci
> platform follow the example of musb, and add the
> "-da8xx" postfix to the driver name.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  drivers/usb/host/ohci-da8xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index bd6cf3c..b3de8bc 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -27,7 +27,7 @@
>  #include "ohci.h"
>  
>  #define DRIVER_DESC "DA8XX"
> -#define DRV_NAME "ohci"
> +#define DRV_NAME "ohci-da8xx"

To which baseline does this patch apply? I don't see this code in
linux-next.

Thanks,
Sekhar

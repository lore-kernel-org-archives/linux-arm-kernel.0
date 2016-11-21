From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 18:10:50 +0100
Subject: [PATCH v2 3/3] usb: ohci-da8xx: rename driver to ohci-da8xx
In-Reply-To: <20161103160308.29588-4-ahaslam@baylibre.com>
References: <20161103160308.29588-1-ahaslam@baylibre.com>
 <20161103160308.29588-4-ahaslam@baylibre.com>
Message-ID: <CAKXjFTME9Y+KEg21i05zP6+10tB4bW=cMbSftAbYhozEg1B8ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Thu, Nov 3, 2016 at 5:03 PM, Axel Haslam <ahaslam@baylibre.com> wrote:
> The davinci ohci driver name (currently "ohci") is too generic.
> To be consistent with other usb dirvers, append the "-da8xx" postfix
> to the name.
>

if there are no objections, would it be possible to pick up this patch?
the corresponding phy patch was merged and the platform changes
are ack'ed, and will we taken by the davinci maintainer once this patch
gets in.

i can resend stand-alone if its preferred.

Regards
Axel

> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  drivers/usb/host/ohci-da8xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index 30c4878..429d58b 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -27,7 +27,7 @@
>  #include "ohci.h"
>
>  #define DRIVER_DESC "DA8XX"
> -#define DRV_NAME "ohci"
> +#define DRV_NAME "ohci-da8xx"
>
>  static struct hc_driver __read_mostly ohci_da8xx_hc_driver;
>
> --
> 2.10.1
>

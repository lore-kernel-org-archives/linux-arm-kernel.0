From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Dec 2011 15:29:57 +0200
Subject: [PATCH 2/7] s3c-hsudc: add __devinit to probe function
In-Reply-To: <201112191424.58081.heiko@sntech.de>
References: <201112191423.21461.heiko@sntech.de>
 <201112191424.58081.heiko@sntech.de>
Message-ID: <20111219132956.GF3146@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 02:24:57PM +0100, Heiko St?bner wrote:

I need a commit log, even if it's an obvious one. Sorry for the
nit-picking.

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/usb/gadget/s3c-hsudc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
> index 4c1abb1..3e5673d 100644
> --- a/drivers/usb/gadget/s3c-hsudc.c
> +++ b/drivers/usb/gadget/s3c-hsudc.c
> @@ -1260,7 +1260,7 @@ static struct usb_gadget_ops s3c_hsudc_gadget_ops = {
>  	.vbus_draw	= s3c_hsudc_vbus_draw,
>  };
>  
> -static int s3c_hsudc_probe(struct platform_device *pdev)
> +static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
> -- 
> 1.7.5.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111219/2c8dcbaa/attachment-0001.sig>

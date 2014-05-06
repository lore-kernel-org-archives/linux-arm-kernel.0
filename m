From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 May 2014 22:00:39 -0500
Subject: [PATCH v3 05/20] usb: host: xhci-plat: Add clocks support
In-Reply-To: <1399335255-589-6-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140506030039.GA15336@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 02:14:00AM +0200, Gregory CLEMENT wrote:
> @@ -118,7 +158,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  
>  	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
>  	if (!hcd)
> -		return -ENOMEM;
> +		ret = -ENOMEM;

regression

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140505/2639bc01/attachment.sig>

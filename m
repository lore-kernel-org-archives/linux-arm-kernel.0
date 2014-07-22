From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 10:34:03 +0800
Subject: [PATCH 4/6] chipidea: usbmisc_imx: Add USB support for VF610 SoCs
In-Reply-To: <e776c8a6ea0d919edb5e3ce1bf0697b23f09f028.1405702442.git.stefan@agner.ch>
References: <cover.1405702442.git.stefan@agner.ch>
 <e776c8a6ea0d919edb5e3ce1bf0697b23f09f028.1405702442.git.stefan@agner.ch>
Message-ID: <20140722023402.GT8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 07:01:40PM +0200, Stefan Agner wrote:
> @@ -283,6 +307,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
>  		.compatible = "fsl,imx6q-usbmisc",
>  		.data = &imx6q_usbmisc_ops,
>  	},
> +	{
> +		.compatible = "fsl,vf610-usbmisc",

Update Documentation/devicetree/bindings/usb/usbmisc-imx.txt please.

Shawn

> +		.data = &vf610_usbmisc_ops,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, usbmisc_imx_dt_ids);

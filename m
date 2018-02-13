From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 13 Feb 2018 13:32:26 +0000
Subject: [PATCH v2] MAINTAINERS: add Freescale pin controllers
In-Reply-To: <20180212150549.8622-1-stefan@agner.ch>
References: <20180212150549.8622-1-stefan@agner.ch>
Message-ID: <AM3PR04MB306CC7D8349BD66C47BDD0180F60@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

> -----Original Message-----
> From: Stefan Agner [mailto:stefan at agner.ch]
> Sent: Monday, February 12, 2018 11:06 PM
> To: linus.walleij at linaro.org; A.s. Dong <aisheng.dong@nxp.com>; Fabio
> Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org;
> kernel at pengutronix.de
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> Stefan Agner <stefan@agner.ch>
> Subject: [PATCH v2] MAINTAINERS: add Freescale pin controllers
> 
> Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer and
> the Pengutronix kernel team as reviewer.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks for sending this.
Besides Joe's comments, I'm fine with it.
So:
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82ad0eabce4f..df60ca7c3355 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10768,6 +10768,17 @@ L:	linux-gpio at vger.kernel.org
>  S:	Supported
>  F:	drivers/pinctrl/pinctrl-at91-pio4.*
> 
> +PIN CONTROLLER - FREESCALE
> +M:	Dong Aisheng <aisheng.dong@nxp.com>
> +M:	Fabio Estevam <festevam@gmail.com>
> +M:	Shawn Guo <shawnguo@kernel.org>
> +M:	Stefan Agner <stefan@agner.ch>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-gpio at vger.kernel.org
> +S:	Maintained
> +F:	drivers/pinctrl/freescale/*
> +F:	Documentation/devicetree/bindings/pinctrl/fsl,*
> +
>  PIN CONTROLLER - INTEL
>  M:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> --
> 2.16.1

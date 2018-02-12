From: joe@perches.com (Joe Perches)
Date: Mon, 12 Feb 2018 07:55:21 -0800
Subject: [PATCH v2] MAINTAINERS: add Freescale pin controllers
In-Reply-To: <20180212150549.8622-1-stefan@agner.ch>
References: <20180212150549.8622-1-stefan@agner.ch>
Message-ID: <1518450921.4139.9.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-02-12 at 16:05 +0100, Stefan Agner wrote:
> Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
> and the Pengutronix kernel team as reviewer.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
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

The * here should probably be removed so perhaps just

F:	drivers/pinctrl/freescale/

> +F:	Documentation/devicetree/bindings/pinctrl/fsl,*
> +
>  PIN CONTROLLER - INTEL
>  M:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>

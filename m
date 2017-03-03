From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Mar 2017 07:36:54 +0100
Subject: [PATCH v1] nvmem: i.MX IIM driver
In-Reply-To: <20170213153149.11710-1-s.hauer@pengutronix.de>
References: <20170213153149.11710-1-s.hauer@pengutronix.de>
Message-ID: <20170303063654.osmmhi5v6yne5ij5@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas, Maxime,

Any comments on this one?

Sascha

On Mon, Feb 13, 2017 at 04:31:47PM +0100, Sascha Hauer wrote:
> 
> This adds a readonly nvmem driver for the i.MX IC Identification Module (IIM)
> which is found on the older i.MX SoCs. The IIM is part of the i.MX dts files
> for long now, but so far there is no binding document for it, so add one now.
> 
> Sascha
> 
> ----------------------------------------------------------------
> Michael Grzeschik (1):
>       nvmem: Add driver for the i.MX IIM
> 
> Sascha Hauer (1):
>       dt-bindings: nvmem: Add i.MX IIM binding doc
> 
>  .../devicetree/bindings/nvmem/imx-iim.txt          |  22 +++
>  drivers/nvmem/Kconfig                              |  11 ++
>  drivers/nvmem/Makefile                             |   2 +
>  drivers/nvmem/imx-iim.c                            | 171 +++++++++++++++++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.txt
>  create mode 100644 drivers/nvmem/imx-iim.c
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

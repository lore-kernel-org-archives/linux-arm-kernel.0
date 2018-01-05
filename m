From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Jan 2018 10:49:30 -0600
Subject: [PATCH 3/7] ARM: dts: imx6ull: add additional pinfunc defines
 for i.MX 6ULL
In-Reply-To: <20180102164223.15230-3-stefan@agner.ch>
References: <20180102164223.15230-1-stefan@agner.ch>
 <20180102164223.15230-3-stefan@agner.ch>
Message-ID: <20180105164930.qomk75eo7vzyglvn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 05:42:19PM +0100, Stefan Agner wrote:
> From: Bai Ping <ping.bai@nxp.com>
> 
> On i.MX 6ULL, the pin MUX and CTRL register of BOOT_MODEx and TAMPERx
> pins are available through IOMUXC_SNVS. Add additional pinfunc defines.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/imx6ull-pinfunc-snvs.h | 29 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6ull.dtsi           |  1 +
>  2 files changed, 30 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
> 
> diff --git a/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
> new file mode 100644
> index 000000000000..da3f412e4269
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.

It's 2018 now.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Use SPDX. With that,

Reviewed-by: Rob Herring <robh@kernel.org>

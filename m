From: julien.chauveau@neo-technologies.fr (NEO-Technologies / Julien CHAUVEAU)
Date: Mon, 27 Oct 2014 08:36:43 +0100
Subject: [PATCH v1 1/4] ARM: dts: rockchip: Add devicetree source for
 MarsBoard RK3066
In-Reply-To: <1414329829-8031-1-git-send-email-romain.perier@gmail.com>
References: <1414329829-8031-1-git-send-email-romain.perier@gmail.com>
Message-ID: <544DF60B.4070909@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,

Le 26/10/2014 14:23, Romain Perier a ?crit :
> diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
> new file mode 100644
> index 0000000..d7d4cd1
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright (c) 2014 Romain Perier <romain.perier@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +#include "rk3066a.dtsi"
> +
> +/ {
> +	model = "MarsBoard RK3066";
> +	compatible = "haoyuelectronics,marsboard-rk3066", "rockchip,rk3066a";

I think you should use "haoyu" for the vendor prefix, according to 
Documentation/devicetree/bindings/vendor-prefixes.txt

Julien

From: nm@ti.com (Nishanth Menon)
Date: Tue, 11 Feb 2014 14:11:23 -0600
Subject: [PATCH 2/2] ARM: dts: N900: add missing compatible property
In-Reply-To: <1391947956-24462-2-git-send-email-aaro.koskinen@iki.fi>
References: <1391947956-24462-1-git-send-email-aaro.koskinen@iki.fi>
 <1391947956-24462-2-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <52FA83EB.2080605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2014 06:12 AM, Aaro Koskinen wrote:
> Add missing compatible property to avoid problems in the future.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reviewed-by: Nishanth Menon <nm@ti.com>

> ---
>  arch/arm/boot/dts/omap3-n900.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 6fc85f963530..0bf40c90faba 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -1,6 +1,6 @@
>  /*
>   * Copyright (C) 2013 Pavel Machek <pavel@ucw.cz>
> - * Copyright 2013 Aaro Koskinen <aaro.koskinen@iki.fi>
> + * Copyright (C) 2013-2014 Aaro Koskinen <aaro.koskinen@iki.fi>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 (or later) as
> @@ -13,7 +13,7 @@
>  
>  / {
>  	model = "Nokia N900";
> -	compatible = "nokia,omap3-n900", "ti,omap3";
> +	compatible = "nokia,omap3-n900", "ti,omap3430", "ti,omap3";
>  
>  	cpus {
>  		cpu at 0 {
> 


-- 
Regards,
Nishanth Menon

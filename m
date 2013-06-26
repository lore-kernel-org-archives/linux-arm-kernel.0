From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Jun 2013 09:55:54 +0200
Subject: [PATCH 4/5] ARM: AT91: dt: add at91rm9200 PQFP package version
In-Reply-To: <1371472710-18535-4-git-send-email-plagnioj@jcrosoft.com>
References: <20130617123645.GA21034@game.jcrosoft.org>
 <1371472710-18535-1-git-send-email-plagnioj@jcrosoft.com>
 <1371472710-18535-4-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <51CA9E8A.3080708@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2013 14:38, Jean-Christophe PLAGNIOL-VILLARD :
> the PQFP version have only 3 gpio banks (A, B & C)
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   arch/arm/boot/dts/at91rm9200_pqfp.dtsi |   17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>   create mode 100644 arch/arm/boot/dts/at91rm9200_pqfp.dtsi
>
> diff --git a/arch/arm/boot/dts/at91rm9200_pqfp.dtsi b/arch/arm/boot/dts/at91rm9200_pqfp.dtsi
> new file mode 100644
> index 0000000..8e3d43f
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91rm9200_pqfp.dtsi
> @@ -0,0 +1,17 @@
> +/*
> + * at91rm9200_pqfp.dtsi - Device Tree Include file for AT91RM9200 PQFP family SoC
> + *
> + * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include "at91rm9200.dtsi"
> +
> +/ {
> +	compatible = "atmel,at91rm9200-pqfp", "atmel,at91rm9200";
> +};
> +
> +&pioD {
> +	status = "disable";

Typo: s/disable/disabled/

> +};
>


-- 
Nicolas Ferre

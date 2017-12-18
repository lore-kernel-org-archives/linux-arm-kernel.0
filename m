From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:09:17 +0100
Subject: [PATCH v2 19/19] ARM: dts: aspeed-plametto: Add flash layout
In-Reply-To: <20171215062443.23059-20-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-20-joel@jms.id.au>
Message-ID: <4c112b91-f2db-79b6-ca4c-f5b290c74773@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> The OpenBMC flash layout is used by Palmetto systems.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>



Reviewed-by: C?dric Le Goater <clg@kaod.org>

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> index a8f0c046e83e..cc18137386f2 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> @@ -34,6 +34,7 @@
>  		status = "okay";
>  		m25p,fast-read;
>  		label = "bmc";
> +#include "openbmc-flash-layout.dtsi"
>  	};
>  };
>  
> 

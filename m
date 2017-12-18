From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:06:13 +0100
Subject: [PATCH v2 14/19] ARM: dts: aspeed: Sort ASPEED entries in makefile
In-Reply-To: <20171215062443.23059-15-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-15-joel@jms.id.au>
Message-ID: <371c410f-44ff-cdba-a820-eb24e0fb618a@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> In preperation for adding more boards.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C?dric Le Goater <clg@kaod.org>

> ---
>  arch/arm/boot/dts/Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9caf21..5d1e9d37bf3a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1101,7 +1101,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  	mt8127-moose.dtb \
>  	mt8135-evbp1.dtb
>  dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
> -dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-opp-palmetto.dtb \
> -	aspeed-bmc-opp-romulus.dtb \
> -	aspeed-ast2500-evb.dtb
> +dtb-$(CONFIG_ARCH_ASPEED) += \
> +	aspeed-ast2500-evb.dtb \
> +	aspeed-bmc-opp-palmetto.dtb \
> +	aspeed-bmc-opp-romulus.dtb
>  endif
> 

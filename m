From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 25 Jun 2013 12:35:48 +0200
Subject: [PATCH 5/5] ARM: at91: at91rm9200: set default mmc0 pinctrl-names
In-Reply-To: <1371472710-18535-5-git-send-email-plagnioj@jcrosoft.com>
References: <20130617123645.GA21034@game.jcrosoft.org>
 <1371472710-18535-1-git-send-email-plagnioj@jcrosoft.com>
 <1371472710-18535-5-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <51C97284.40300@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2013 14:38, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/boot/dts/at91rm9200.dtsi |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
> index 1fc645e..8bc87e5 100644
> --- a/arch/arm/boot/dts/at91rm9200.dtsi
> +++ b/arch/arm/boot/dts/at91rm9200.dtsi
> @@ -116,6 +116,7 @@
>   				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 0>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> +				pinctrl-names = "default";

You do not add a pinctrl cell: is it normal? Which pinctrl definition 
does it take then?

>   				status = "disabled";
>   			};
>
>


-- 
Nicolas Ferre

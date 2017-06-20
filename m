From: jic23@kernel.org (Jonathan Cameron)
Date: Tue, 20 Jun 2017 17:56:19 +0100
Subject: [PATCH v5 3/4] ARM: dts: at91: sama5d2: add ADC hw trigger edge
 type
In-Reply-To: <1497533097-12052-4-git-send-email-eugen.hristev@microchip.com>
References: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
 <1497533097-12052-4-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20170620175619.0a93d3d2@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Jun 2017 16:24:56 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Added ADTRG edge type property as interrupt edge type value
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Driver support heading upstream.

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   Changes in v4:
>  - Modified bindings to be similar with interrupts
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 8067c71..483a387 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1267,6 +1267,7 @@
>  				atmel,min-sample-rate-hz = <200000>;
>  				atmel,max-sample-rate-hz = <20000000>;
>  				atmel,startup-time-ms = <4>;
> +				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
>  				status = "disabled";
>  			};
>  

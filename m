From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 2 Jun 2017 06:14:17 -0700
Subject: [PATCH v4 1/2] Documentation: bindings: add
 amlogic,meson-gxbb-scpi-sensors compatible
In-Reply-To: <20170530090507.16611-2-carlo@caione.org>
References: <20170530090507.16611-1-carlo@caione.org>
 <20170530090507.16611-2-carlo@caione.org>
Message-ID: <8d0c867e-2b78-63fa-f422-709e515012ca@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2017 02:05 AM, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Introduce a new Amlogic specific compatible to handle how Amlogic reports
> the sensor readings from SCPI using a different scale.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Formally waiting for DT approval. However, I don't see any problems with it,
so

Acked-by: Guenter Roeck <linux@roeck-us.net>

Not sure what branch this is supposed to go through. For now I assume it
will be arm/arm64.

Thanks,
Guenter

> ---
>   Documentation/devicetree/bindings/arm/arm,scpi.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> index 4018319..40f50c1 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -76,7 +76,7 @@ Sensor bindings for the sensors based on SCPI Message Protocol
>   SCPI provides an API to access the various sensors on the SoC.
>   
>   Required properties:
> -- compatible : should be "arm,scpi-sensors".
> +- compatible : should be "arm,scpi-sensors" or "amlogic,meson-gxbb-scpi-sensors"
>   - #thermal-sensor-cells: should be set to 1. This property follows the
>   			 thermal device tree bindings[2].
>   
> 

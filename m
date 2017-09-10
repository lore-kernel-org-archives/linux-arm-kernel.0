From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 10 Sep 2017 08:17:30 -0700
Subject: [PATCH v2 1/3] dt-bindings: watchdog: Add Realtek RTD1295
In-Reply-To: <20170904231602.29787-2-afaerber@suse.de>
References: <20170904231602.29787-1-afaerber@suse.de>
 <20170904231602.29787-2-afaerber@suse.de>
Message-ID: <2e66bbc5-3907-d39d-8f2b-eda28269373e@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2017 04:16 PM, Andreas F?rber wrote:
> Add a binding for the Realtek RTD1295 watchdog.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   v1 -> v2: Unchanged
>   
>   .../devicetree/bindings/watchdog/realtek,rtd119x.txt    | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt b/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
> new file mode 100644
> index 000000000000..05653054bd5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
> @@ -0,0 +1,17 @@
> +Realtek RTD1295 Watchdog
> +========================
> +
> +Required properties:
> +
> +- compatible :  Should be "realtek,rtd1295-watchdog"
> +- reg        :  Specifies the physical base address and size of registers
> +- clocks     :  Specifies one clock input
> +
> +
> +Example:
> +
> +	watchdog at 98007680 {
> +		compatible = "realtek,rtd1295-watchdog";
> +		reg = <0x98007680 0x100>;
> +		clocks = <&osc27M>;
> +	};
> 

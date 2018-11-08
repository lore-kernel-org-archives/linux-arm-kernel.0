From: nm@ti.com (Nishanth Menon)
Date: Thu, 8 Nov 2018 07:47:23 -0600
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65: Add pinctrl regions
In-Reply-To: <20181108112647.7205-3-vigneshr@ti.com>
References: <20181108112647.7205-1-vigneshr@ti.com>
 <20181108112647.7205-3-vigneshr@ti.com>
Message-ID: <20181108134723.utbk7322xlqzjcfq@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:56-20181108, Vignesh R wrote:
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index 3d4bf369d030..873dca1d0813 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/k3-am65.h>
>  
>  / {
>  	model = "Texas Instruments K3 AM654 SoC";
> -- 
> 2.19.1
> 

Where is this used? Could we mux the uart console that we are using?
will be good to see an example of usage.

-- 
Regards,
Nishanth Menon

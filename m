From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 9 Jun 2017 10:14:38 +0200
Subject: [PATCH 3/3] arm: dts: mt2701: Add display subsystem related nodes
 for MT2701
In-Reply-To: <1496297324-21091-4-git-send-email-erin.lo@mediatek.com>
References: <1496297324-21091-1-git-send-email-erin.lo@mediatek.com>
 <1496297324-21091-4-git-send-email-erin.lo@mediatek.com>
Message-ID: <eafa6c79-4d12-abf5-f8ec-e91c6cc22cd4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/06/17 08:08, Erin Lo wrote:
> From: YT Shen <yt.shen@mediatek.com>
> 
> This patch adds the device nodes for the DISP function blocks for MT2701
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>   arch/arm/boot/dts/mt2701.dtsi | 84 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 4f110d5..e20b65c 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -17,6 +17,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/reset/mt2701-resets.h>
> +#include <dt-bindings/memory/mt2701-larb-port.h>
>   #include "skeleton64.dtsi"
>   #include "mt2701-pinfunc.h"
>   
> @@ -24,6 +25,11 @@
>   	compatible = "mediatek,mt2701";
>   	interrupt-parent = <&sysirq>;
>   
> +	aliases {
> +		rdma0 = &rdma0;
> +		rdma1 = &rdma1;
> +	};
> +

I know we have this alias in mt8173.dtsi, but I don't understand what 
they are for. Do you know?

Regards,
Matthias

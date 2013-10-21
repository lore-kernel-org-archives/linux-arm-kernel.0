From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 21 Oct 2013 23:01:15 +0400
Subject: [PATCH] ARM: dts: am4372: Add McASP nodes
In-Reply-To: <1382348758-1083-1-git-send-email-peter.ujfalusi@ti.com>
References: <1382348758-1083-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <526579FB.10005@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/21/2013 01:45 PM, Peter Ujfalusi wrote:

> Add nodes for McASP0 and McASP1 for AM43xx.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   arch/arm/boot/dts/am4372.dtsi | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)

> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index c328d5c..defaad1 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -633,5 +633,32 @@
>   			dma-names = "tx", "rx";
>   		};
>
> +		mcasp0: mcasp at 48038000 {

    According to ePAPR spec [1], "the name of a node should be somewhat 
generic, reflecting the function of the device and not its
precise programming model". In this case probably "sound"?

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei

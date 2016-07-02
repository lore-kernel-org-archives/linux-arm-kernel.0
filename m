From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 2 Jul 2016 20:07:00 +0300
Subject: [PATCH 1/3] ARM: dts: r8a7792: add PFC support
In-Reply-To: <7894702.b5qeLxoHdo@wasted.cogentembedded.com>
References: <2144803.0K8qXzjIFq@wasted.cogentembedded.com>
 <7894702.b5qeLxoHdo@wasted.cogentembedded.com>
Message-ID: <c0aad99a-ca5d-4f4a-408b-2d305fa6bab5@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/01/2016 02:06 AM, Sergei Shtylyov wrote:

> Define the generic R8A7792 part of the PFC device node.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/boot/dts/r8a7792.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7792.dtsi
> @@ -108,6 +108,12 @@
>  			#power-domain-cells = <1>;
>  		};
>
> +

    Just noticed this extra empty line... :-/

> +		pfc: pin-controller at e6060000 {
> +			compatible = "renesas,pfc-r8a7792";
> +			reg = <0 0xe6060000 0 0x144>;
> +		};
> +
>  		dmac0: dma-controller at e6700000 {
>  			compatible = "renesas,dmac-r8a7792",
>  				     "renesas,rcar-dmac";

    Will repost.

MBR, Sergei

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 03 Jul 2014 21:25:28 +0400
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: add CAN DT support
In-Reply-To: <201407030243.25237.sergei.shtylyov@cogentembedded.com>
References: <201407030239.15921.sergei.shtylyov@cogentembedded.com>
 <201407030243.25237.sergei.shtylyov@cogentembedded.com>
Message-ID: <53B59208.703@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/03/2014 02:43 AM, Sergei Shtylyov wrote:

> Define the generic R8A7791 parts of the CAN0/1 device nodes.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
>   arch/arm/boot/dts/r8a7791.dtsi |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

> Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7791.dtsi
> @@ -518,6 +518,22 @@
>   		status = "disabled";
>   	};
>
> +	can0: can at e6e80000 {
> +		compatible = "renesas,rcar-can";

    Oops, this ain't gonna fly with the current CAN driver patch... :-(
I'll repost.

WBR, Sergei

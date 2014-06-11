From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 12 Jun 2014 03:53:40 +0400
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: add VIN DT support
In-Reply-To: <201406110306.08759.sergei.shtylyov@cogentembedded.com>
References: <201406110304.18976.sergei.shtylyov@cogentembedded.com>
 <201406110306.08759.sergei.shtylyov@cogentembedded.com>
Message-ID: <5398EC04.5040802@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/11/2014 03:06 AM, Sergei Shtylyov wrote:

> Define the generic R8A7791 parts of the VIN[0-2] device nodes. Add aliases for
> the VIN[0-2] device nodes.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
>   arch/arm/boot/dts/r8a7791.dtsi |   27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)

> Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7791.dtsi
[...]
> @@ -518,6 +521,30 @@
>   		status = "disabled";
>   	};
>
> +	vin0: video at e6ef0000 {
> +		compatible = "renesas,vin-r8a7790";

    Duh, should have been "renesas,vin-r8a7791"...

WBR, Sergei

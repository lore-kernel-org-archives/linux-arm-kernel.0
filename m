From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 02 Jul 2014 16:03:42 +0400
Subject: [PATCH/RFC 2/6] ARM: shmobile: r8a7778: Add SCIF nodes
In-Reply-To: <1404275322-26514-3-git-send-email-horms+renesas@verge.net.au>
References: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
 <1404275322-26514-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <53B3F51E.9000505@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/02/2014 08:28 AM, Simon Horman wrote:

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/r8a7778.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 3af0a21..55357dc 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -156,6 +156,54 @@
>   		status = "disabled";
>   	};
>
> +	scif0: serial at ffe40000 {
> +		compatible = "renesas,scif-r8a7778", "renesas,scif";
> +		reg = <0xffe40000 0x100>;
> +		interrupt-parent = <&gic>;

    Not needed here and below -- it's already specified in the root node.

WBR, Sergei

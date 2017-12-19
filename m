From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 19 Dec 2017 12:27:48 +0300
Subject: [PATCH 1/2] ARM: dts: r8a7792: sort root sub-nodes alphabetically
In-Reply-To: <20171218213233.3373-2-horms+renesas@verge.net.au>
References: <20171218213233.3373-1-horms+renesas@verge.net.au>
 <20171218213233.3373-2-horms+renesas@verge.net.au>
Message-ID: <14c60234-3755-3b06-64fc-e3943d8b5293@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 12/19/2017 12:32 AM, Simon Horman wrote:

> Sort root sub-nodes alphabetically for allow for easier maintenance

    s/for/to/?

> of this file.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/r8a7792.dtsi | 48 +++++++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
> index ac05fdb91798..d31258958c36 100644
> --- a/arch/arm/boot/dts/r8a7792.dtsi
> +++ b/arch/arm/boot/dts/r8a7792.dtsi
> @@ -36,6 +36,22 @@
>   		vin5 = &vin5;
>   	};
>   
> +	/* External root clock */
> +	extal_clk: extal {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board. */
> +		clock-frequency = <0>;
> +	};
> +
> +	/* External CAN clock */
> +	can_clk: can {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board. */
> +		clock-frequency = <0>;
> +	};
> +

    C predates E in my alphabet. :-)

>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
[...]

MBR, Sergei

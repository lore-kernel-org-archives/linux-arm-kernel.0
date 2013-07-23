From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Jul 2013 10:33:43 +0900
Subject: [PATCH 19/22] ARM: shmobile: r8a7779: Remove '0x's from R8A7779
 DTS file
In-Reply-To: <1374490361-25769-19-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-19-git-send-email-lee.jones@linaro.org>
Message-ID: <20130723013343.GG16481@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 11:52:38AM +0100, Lee Jones wrote:
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Let me know if you want me to take this through the renesas tree.

> ---
>  arch/arm/boot/dts/r8a7779.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index 7f146c6..86bd487 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -65,7 +65,7 @@
>  		sense-bitfield-width = <2>;
>  	};
>  
> -	i2c0: i2c at 0xffc70000 {
> +	i2c0: i2c at ffc70000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "renesas,rmobile-iic";
> @@ -74,7 +74,7 @@
>  		interrupts = <0 79 0x4>;
>  	};
>  
> -	i2c1: i2c at 0xffc71000 {
> +	i2c1: i2c at ffc71000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "renesas,rmobile-iic";
> @@ -83,7 +83,7 @@
>  		interrupts = <0 82 0x4>;
>  	};
>  
> -	i2c2: i2c at 0xffc72000 {
> +	i2c2: i2c at ffc72000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "renesas,rmobile-iic";
> @@ -92,7 +92,7 @@
>  		interrupts = <0 80 0x4>;
>  	};
>  
> -	i2c3: i2c at 0xffc73000 {
> +	i2c3: i2c at ffc73000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "renesas,rmobile-iic";
> -- 
> 1.8.1.2
> 

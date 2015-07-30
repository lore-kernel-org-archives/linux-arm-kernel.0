From: stefan@agner.ch (Stefan Agner)
Date: Thu, 30 Jul 2015 18:43:29 +0200
Subject: [PATCH v2] ARM: dts: vf-colibri: define stdout-path property
In-Reply-To: <1436971817-28523-1-git-send-email-stefan@agner.ch>
References: <1436971817-28523-1-git-send-email-stefan@agner.ch>
Message-ID: <0af90d47043467591155c16f621cc1da@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Did you notice this change? Just asking since you applied some other
changes already...

--
Stefan

On 2015-07-15 16:50, Stefan Agner wrote:
> Define Vybrid's UART0, connected to the Colibri pinout UART_A, as
> standard output.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> index 77e1a45..2ce6fe5 100644
> --- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> @@ -9,7 +9,7 @@
>  
>  / {
>  	chosen {
> -		bootargs = "console=ttyLP0,115200";
> +		stdout-path = "serial0:115200n8";
>  	};
>  
>  	clk16m: clk16m {

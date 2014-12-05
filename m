From: alexanders83@web.de (Alexander Stein)
Date: Fri, 05 Dec 2014 16:00:27 +0100
Subject: [PATCH 1/2] ARM: at91/dt: sam9263: Fix typo: ac91_clk -> ac97_clk
In-Reply-To: <1417789016-20001-1-git-send-email-alexanders83@web.de>
References: <1417789016-20001-1-git-send-email-alexanders83@web.de>
Message-ID: <2676241.BfXNcaGQ7Q@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 December 2014, 15:16:55 wrote Alexander Stein:
> That clock should be called ac97_clk.
> 
> Signed-off-by: Alexander Stein <alexanders83@web.de>
> ---
>  arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index 7989756..5ed2810 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -294,7 +294,7 @@
>  						reg = <17>;
>  					};
>  
> -					ac91_clk: ac97_clk {
> +					ac97_clk: ac97_clk {
>  						#clock-cells = <0>;
>  						reg = <18>;
>  					};
> 

Please ignore those 2 patches for now. I made a mistake during local rebase.

Best regards,
Alexander

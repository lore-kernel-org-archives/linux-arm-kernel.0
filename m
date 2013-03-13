From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Mar 2013 10:19:31 +0100
Subject: [PATCH 1/2] arm: at91: dt: at91sam9x5: correct NAND pins comments
In-Reply-To: <1363011160-11297-1-git-send-email-richard.genoud@gmail.com>
References: <1363011160-11297-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <514044A3.7000000@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 03:12 PM, Richard Genoud :
> Comments on NAND pins where inverted.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
> based on 3.9-rc2
> 
>  arch/arm/boot/dts/at91sam9x5.dtsi |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index aa98e64..9b5d048 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -238,8 +238,8 @@
>  				nand {
>  					pinctrl_nand: nand-0 {
>  						atmel,pins =
> -							<3 4 0x0 0x1	/* PD5 gpio RDY pin pull_up */
> -							 3 5 0x0 0x1>;	/* PD4 gpio enable pin pull_up */
> +							<3 4 0x0 0x1	/* PD4 gpio Chip Enable pin pull_up */
> +							 3 5 0x0 0x1>;	/* PD5 gpio RDY/BUSY pin pull_up */
>  					};
>  				};
>  
> 

Thanks, both queued in at91-3.9-fixes branch.

Best regards,
-- 
Nicolas Ferre

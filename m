From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 13 May 2014 11:52:59 +0200
Subject: [PATCH] ARM: at91/dt: sam9260: correct external trigger value
In-Reply-To: <1399912375-6247-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1399912375-6247-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5371EB7B.1050608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2014 18:32, Alexandre Belloni :
> The external trigger value is 0b1101 which is 13 but 0xd.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and pushed on our at91-3.15-fixes branch. I will try to push it for 3.15...

Thanks, bye,

> ---
>  arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index 366fc2cbcd64..c0e0eae16a27 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -641,7 +641,7 @@
>  				trigger at 3 {
>  					reg = <3>;
>  					trigger-name = "external";
> -					trigger-value = <0x13>;
> +					trigger-value = <0xd>;
>  					trigger-external;
>  				};
>  			};
> 


-- 
Nicolas Ferre

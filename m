From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 14 Apr 2014 10:57:54 +0200
Subject: [PATCH 3/4] ARM: at91/dt: define sam9n12ek crystal frequencies
In-Reply-To: <1397463399-11771-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1397463399-11771-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397463399-11771-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140414085754.GM2967@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/2014 at 10:16:38 +0200, Boris Brezillon wrote :
> Define sam9n12ek's main and slow crystal frequencies.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91sam9n12ek.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index 924a6a6..6132769 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -30,6 +30,14 @@
>  			compatible = "atmel,osc", "fixed-clock";
>  			clock-frequency = <16000000>;
>  		};
> +
> +		slow_xtal: slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal: main_xtal {
> +			clock-frequency = <16000000>;
> +		};
>  	};
>  
>  	ahb {
> -- 
> 1.8.3.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

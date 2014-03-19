From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Mar 2014 16:40:56 +0100
Subject: [PATCH 11/11] ARM: at91/dt: define sam9rlek crystal frequencies
In-Reply-To: <1395173924-3648-12-git-send-email-b.brezillon.dev@gmail.com>
References: <1395173924-3648-1-git-send-email-b.brezillon.dev@gmail.com>
 <1395173924-3648-12-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140319154055.GO12021@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/2014 at 21:18:44 +0100, Boris BREZILLON wrote :
> Define at91sam9rlek crystal frequencies.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/boot/dts/at91sam9rlek.dts |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
> index cddb378..85b68b9 100644
> --- a/arch/arm/boot/dts/at91sam9rlek.dts
> +++ b/arch/arm/boot/dts/at91sam9rlek.dts
> @@ -25,6 +25,14 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		slow_xtal: slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal: main_xtal {
> +			clock-frequency = <12000000>;
> +		};
> +
>  		main_clock: clock {
>  			compatible = "atmel,osc", "fixed-clock";
>  			clock-frequency = <12000000>;
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

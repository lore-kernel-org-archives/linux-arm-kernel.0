From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 14 Apr 2014 11:09:00 +0200
Subject: [PATCH 3/4] ARM: at91/dt: define sam9x5ek's crystal frequencies
In-Reply-To: <1397464994-27267-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1397464994-27267-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397464994-27267-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140414090900.GQ2967@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/2014 at 10:43:13 +0200, Boris Brezillon wrote :
> Define sam9x5ek's main and slow crystal frequencies.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91sam9x5cm.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
> index 4a5ee5c..2798b02 100644
> --- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
> @@ -23,6 +23,14 @@
>  		};
>  	};
>  
> +	slow_xtal: slow_xtal {
> +		clock-frequency = <32768>;
> +	};
> +
> +	main_xtal: main_xtal {
> +		clock-frequency = <12000000>;
> +	};
> +
>  	ahb {
>  		apb {
>  			pinctrl at fffff400 {
> -- 
> 1.8.3.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

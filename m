From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 3 Nov 2016 14:49:48 -0500
Subject: [PATCHv3 4/4] ARM: socfpga: dts: Add Monitor to A10-SR MFD
In-Reply-To: <1478097178-24341-5-git-send-email-tthayer@opensource.altera.com>
References: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
 <1478097178-24341-5-git-send-email-tthayer@opensource.altera.com>
Message-ID: <dbf3995e-647b-e04d-0045-6a7ed28e7d44@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/02/2016 09:32 AM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the Monitor functionality to the Arria10 DevKit
> System Resource chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2  Change from -mon to -monitor for clarity.
> v3  Change node name from a10_monitor to monitor.
> ---
>  arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> index eb00ae3..996e745 100644
> --- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> @@ -121,6 +121,10 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  		};
> +
> +		monitor {
> +			compatible = "altr,a10sr-monitor";
> +		};
>  	};
>  };
>  
> 

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

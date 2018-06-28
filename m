From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 28 Jun 2018 14:37:54 -0500
Subject: [PATCH] arm64: dts: stratix10: Add SPI node clocks for Stratix10
In-Reply-To: <1530121827-32390-1-git-send-email-thor.thayer@linux.intel.com>
References: <1530121827-32390-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <22497e7f-74dc-2427-6b36-5900fe062d9d@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thor

On 06/27/2018 12:50 PM, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add the required clocks for the new Stratix10 clock bindings
> to the SPI nodes.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index 67dac595dc72..9e54282ee08c 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -310,6 +310,7 @@
>  			resets = <&rst SPIM0_RESET>;
>  			reg-io-width = <4>;
>  			num-cs = <4>;
> +			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
>  			status = "disabled";
>  		};
>  
> @@ -322,6 +323,7 @@
>  			resets = <&rst SPIM1_RESET>;
>  			reg-io-width = <4>;
>  			num-cs = <4>;
> +			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
>  			status = "disabled";
>  		};
>  
> 

I thought you already sent a patch for this?

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/585514.html

Dinh

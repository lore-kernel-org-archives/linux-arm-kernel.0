From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Fri, 21 Aug 2015 17:41:44 +0530
Subject: [PATCH] ARM: dts: vfxxx: Add iio_hwmon node for ADC temperature
 channel
In-Reply-To: <b639ca620369d196491a4af8739b87d580e71bf6.1438876380.git.maitysanchayan@gmail.com>
References: <b639ca620369d196491a4af8739b87d580e71bf6.1438876380.git.maitysanchayan@gmail.com>
Message-ID: <20150821121144.GE2233@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

- Sanchayan.

On 15-08-06 21:28:22, Sanchayan Maity wrote:
> Add iio_hwmon node to expose the temperature channel on Vybrid
> as hardware monitor device using the iio_hwmon driver.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 39173bb..0993d66 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -597,5 +597,10 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		iio_hwmon {
> +			compatible = "iio-hwmon";
> +			io-channels = <&adc0 16>;
> +		};
>  	};
>  };
> -- 
> 2.5.0
> 

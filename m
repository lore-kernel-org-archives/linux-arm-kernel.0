From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Thu, 21 Jan 2016 10:47:18 +0100
Subject: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
In-Reply-To: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
References: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20160121094718.GV7192@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 December 2015 00:32:25 Pali Roh?r wrote:
> Driver for omap3 with documentation is there since v4.4-rc1.
> 
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> ---
>  arch/arm/boot/dts/omap34xx.dtsi |    5 +++++
>  arch/arm/boot/dts/omap36xx.dtsi |    5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> index 4f6b2d5..c3f488f 100644
> --- a/arch/arm/boot/dts/omap34xx.dtsi
> +++ b/arch/arm/boot/dts/omap34xx.dtsi
> @@ -54,6 +54,11 @@
>  				#size-cells = <0>;
>  			};
>  		};
> +
> +		bandgap {
> +			reg = <0x48002524 0x4>;
> +			compatible = "ti,omap34xx-bandgap";
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> index 86253de..00f98c1 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -86,6 +86,11 @@
>  				#size-cells = <0>;
>  			};
>  		};
> +
> +		bandgap {
> +			reg = <0x48002524 0x4>;
> +			compatible = "ti,omap36xx-bandgap";
> +		};
>  	};
>  };
>  

PING! Who can take this patch?

-- 
Pali Roh?r
pali.rohar at gmail.com

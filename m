From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 12 May 2014 13:50:31 +0900
Subject: [PATCH v3 1/4] ARM: dts: enable fimd for exynos5250 based snow
 board
In-Reply-To: <1399630186-22610-2-git-send-email-rahul.sharma@samsung.com>
References: <1399630186-22610-1-git-send-email-rahul.sharma@samsung.com>
 <1399630186-22610-2-git-send-email-rahul.sharma@samsung.com>
Message-ID: <001501cf6d9d$b3ed4c40$1bc7e4c0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 09, 2014 7:10 PM, Rahul Sharma wrote:
> 
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Enable fimd node for snow board.
> 
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/boot/dts/exynos5250-snow.dts |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 1ce1088..796954c 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -206,4 +206,10 @@
>  			clock-frequency = <24000000>;
>  		};
>  	};
> +
> +	fimd at 14400000 {
> +		status = "okay";
> +		samsung,invert-vclk;
> +	};
> +
>  };
> --
> 1.7.9.5

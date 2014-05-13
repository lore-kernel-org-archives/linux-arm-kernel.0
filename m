From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 13 May 2014 10:14:35 +0900
Subject: [PATCH 2/2] ARM: dts: enable fimd for exynos5800 based peach-pi
 board
In-Reply-To: <1399877120-4634-3-git-send-email-rahul.sharma@samsung.com>
References: <1399877120-4634-1-git-send-email-rahul.sharma@samsung.com>
 <1399877120-4634-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <004701cf6e48$b4578910$1d069b30$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 12, 2014 3:45 PM, Rahul Sharma wrote:
> 
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Enable FIMD for peach-pi board.
> 
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/boot/dts/exynos5800-peach-pi.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 426705a..cccacdd 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -157,6 +157,11 @@
>  	};
>  };
> 
> +&fimd {
> +	status = "okay";
> +	samsung,invert-vclk;
> +};
> +
>  &hsi2c_9 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> --
> 1.7.9.5

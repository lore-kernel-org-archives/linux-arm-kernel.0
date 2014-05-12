From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 12 May 2014 13:52:06 +0900
Subject: [PATCH v3 3/4] ARM: dts: enable fimd for exynos5420 based
 peach-pit board
In-Reply-To: <1399630186-22610-4-git-send-email-rahul.sharma@samsung.com>
References: <1399630186-22610-1-git-send-email-rahul.sharma@samsung.com>
 <1399630186-22610-4-git-send-email-rahul.sharma@samsung.com>
Message-ID: <001701cf6d9d$ecacbbb0$c6063310$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 09, 2014 7:10 PM, Rahul Sharma wrote:
> 
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Enable fimd for peach-pit board.
> 
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index fae33dd..f75da5b 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -145,3 +145,8 @@
>  &watchdog {
>  	timeout-sec = <32>;
>  };
> +
> +&fimd {
> +	status = "okay";
> +	samsung,invert-vclk;
> +};
> --
> 1.7.9.5

From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Jul 2013 21:25:35 +0200
Subject: [PATCH 07/22] ARM: exynos: Remove '0x's from Exynos4110 DTSI file
In-Reply-To: <1374490361-25769-7-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-7-git-send-email-lee.jones@linaro.org>
Message-ID: <2350088.9z671SCjFz@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Monday 22 of July 2013 11:52:26 Lee Jones wrote:
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> b/arch/arm/boot/dts/exynos4210.dtsi index b7f358a..53e2527 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -72,7 +72,7 @@
>  		};
>  	};
> 
> -	clock: clock-controller at 0x10030000 {
> +	clock: clock-controller at 10030000 {
>  		compatible = "samsung,exynos4210-clock";
>  		reg = <0x10030000 0x20000>;
>  		#clock-cells = <1>;

This looks fine, but please fix commit message - it should be Exynos4210. 
Also some explanation why this change is needed would be good, even if 
it's obvious.

Best regards,
Tomasz

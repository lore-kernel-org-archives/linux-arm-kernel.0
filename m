From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Nov 2012 21:00:35 +0900
Subject: [PATCH] ARM: dts: exynos4210-trats: Remove broken-voltage property
 from sdhci node
In-Reply-To: <1604189.yDsqlPMQyl@amdc1227>
References: <1604189.yDsqlPMQyl@amdc1227>
Message-ID: <0c9901cdc716$a6284f80$f278ee80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> The broken voltage property has been replaced with auto detection based
> on voltages available on vmmc voltage regulator, so there is no use for
> it now.
> 
> This patch removes the now unused property from Trats Device Tree
> sources.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-trats.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts
> b/arch/arm/boot/dts/exynos4210-trats.dts
> index a21511c..9d5d27a 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -42,7 +42,6 @@
>  	sdhci_emmc: sdhci at 12510000 {
>  		bus-width = <8>;
>  		non-removable;
> -		broken-voltage;
>  		gpios = <&gpk0 0 2 0 3>,
>  			<&gpk0 1 2 0 3>,
>  			<&gpk0 3 2 2 3>,
> --
> 1.8.0

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

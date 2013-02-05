From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Feb 2013 21:32:27 -0800
Subject: [PATCH] ARM: dts: Fix the timing property of MSHC controller
In-Reply-To: <1360025780-17158-1-git-send-email-tobetter@gmail.com>
References: <1358959242-1667-1-git-send-email-tobetter@gmail.com>
 <1360025780-17158-1-git-send-email-tobetter@gmail.com>
Message-ID: <124f01ce0362$30b5eb30$9221c190$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dongjin Kim wrote:
> 
> This fixes the property of dw-mshc-sdr-timing and dw-mshc-ddr-timing as
> per
> its current binding, it only has two cells.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroidx.dts |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts
> b/arch/arm/boot/dts/exynos4412-odroidx.dts
> index f41a84e..009a9c2 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> @@ -49,8 +49,8 @@
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2 3>;
> +		samsung,dw-mshc-sdr-timing = <2 3>;
> +		samsung,dw-mshc-ddr-timing = <1 2>;
> 
>  		slot at 0 {
>  			reg = <0>;
> --
> 1.7.10.4

Looks good to me, applied.

Thanks.

- Kukjin

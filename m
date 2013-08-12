From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 12 Aug 2013 13:17:13 +0200
Subject: [PATCH V4 4/4] ARM: dts: Enable sound support on smdk5420
In-Reply-To: <1376302070-1877-5-git-send-email-padma.v@samsung.com>
References: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
 <1376302070-1877-5-git-send-email-padma.v@samsung.com>
Message-ID: <2159996.Aa92FNgf18@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Padmavathi,

On Monday 12 of August 2013 15:37:50 Padmavathi Venna wrote:
> This patch enables i2s0 and sound support on smdk5420.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-smdk5420.dts |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> b/arch/arm/boot/dts/exynos5420-smdk5420.dts index a898b3f..b1b745c
> 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -139,4 +139,14 @@
>  		};
>  	};
> 
> +	i2s0: i2s at 03830000 {
> +		status = "okay";
> +	};

After addressing my comment on node status for patch 1/4, you could get rid 
of the node above.

Best regards,
Tomasz

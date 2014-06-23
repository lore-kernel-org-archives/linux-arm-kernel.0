From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 23 Jun 2014 20:36:57 +0900
Subject: [PATCH] ARM: DTS: correct the capability string for mmc0
In-Reply-To: <1403522420-1208-1-git-send-email-ch.naveen@samsung.com>
References: <1403522420-1208-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <034701cf8ed7$70c78330$52568990$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen Krishna Chatradhi wrote:
> 
> MMC capability for HS200 is parsed in mmc/core/host.c as
> dts string "mmc-hs200-1_8v".
> 
> This patch corrects the dts string for Exynos5420 based peach-pit
> and Exynos5800 based peach-pi boards.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    2 +-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-
> peach-pit.dts
> index 7649982..7dea480 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -173,7 +173,7 @@
>  	status = "okay";
>  	num-slots = <1>;
>  	broken-cd;
> -	caps2-mmc-hs200-1_8v;
> +	mmc-hs200-1_8v;
>  	supports-highspeed;
>  	non-removable;
>  	card-detect-delay = <200>;
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-
> peach-pi.dts
> index 2c2c137..bb3ee76 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -171,7 +171,7 @@
>  	status = "okay";
>  	num-slots = <1>;
>  	broken-cd;
> -	caps2-mmc-hs200-1_8v;
> +	mmc-hs200-1_8v;
>  	supports-highspeed;
>  	non-removable;
>  	card-detect-delay = <200>;
> --
> 1.7.9.5

Applied, thanks.

- Kukjin

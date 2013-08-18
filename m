From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Aug 2013 04:54:06 +0900
Subject: [PATCH 3/4] ARM: dts: Correct the /include entry on exynos5420
 dtsi file
In-Reply-To: <1373458313-18970-4-git-send-email-padma.v@samsung.com>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
 <1373458313-18970-4-git-send-email-padma.v@samsung.com>
Message-ID: <5211265E.7030808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/13 21:11, Padmavathi Venna wrote:
> This patch corrects the /include to #include on exynos5420
>
> Signed-off-by: Padmavathi Venna<padma.v@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5420.dtsi |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 8c54c4b..da55160 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -14,7 +14,7 @@
>    */
>
>   #include "exynos5.dtsi"
> -/include/ "exynos5420-pinctrl.dtsi"
> +#include "exynos5420-pinctrl.dtsi"
>   / {
>   	compatible = "samsung,exynos5420";
>
Applied, thanks.

- Kukjin

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:23:34 +0900
Subject: [PATCH] ARM: dts: fix bad merge of display timing node to
 exynos5250-smdk5250.dts
In-Reply-To: <1365439879-3398-1-git-send-email-dianders@chromium.org>
References: <1365439879-3398-1-git-send-email-dianders@chromium.org>
Message-ID: <51630B26.1000102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/13 01:51, Doug Anderson wrote:
> The display timing node was added:
>    7ed2077 ARM: dts: Add display timing node to exynos5250-smdk5250.dts
> ...and looks OK there.  ...but it looks like we lost a "};" in the
> merge and it no longer compiles.  Fix it.
>
> Signed-off-by: Doug Anderson<dianders@chromium.org>
> ---
>   arch/arm/boot/dts/exynos5250-smdk5250.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 4be14df..26d856b 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -239,6 +239,7 @@
>   			vback-porch =<4>;
>   			vfront-porch =<4>;
>   			vsync-len =<4>;
> +		};
>   	};
>
>   	fixed-rate-clocks {

Thanks for your pointing out. But it should be fixed with re-sorting out 
the branch.

If any problems, please let me know.

- Kukjin

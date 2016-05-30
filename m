From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 May 2016 08:35:55 +0200
Subject: [PATCH] ARM: exynos_defconfig: Disable big.LITTLE switcher
In-Reply-To: <1493315.8NlXQFsEtt@amdc1976>
References: <1493315.8NlXQFsEtt@amdc1976>
Message-ID: <574BDF4B.5020809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2016 04:44 PM, Bartlomiej Zolnierkiewicz wrote:
> Disable big.LITTLE switcher in order to allow automatic usage of
> cpufreq-dt driver on Exynos542x/Exynos5800 SoCs based boards.
> 
> This change should not cause any problems as arm_big_little[_dt]
> driver (which is using big.LITTLE switcher support to do the "real"
> big.LITTLE switching work) is not used on any Exynos SoC based
> board currently.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 2 --
>  1 file changed, 2 deletions(-)

Thanks, applied.

Krzysztof

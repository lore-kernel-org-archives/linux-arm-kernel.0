From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 30 Nov 2017 19:22:28 +0100
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable missing drivers for
 supported Exynos boards
In-Reply-To: <20171130091004.22971-1-m.szyprowski@samsung.com>
References: <CGME20171130091008eucas1p1968966968d4a0d5cc98d5f481744cd72@eucas1p1.samsung.com>
 <20171130091004.22971-1-m.szyprowski@samsung.com>
Message-ID: <20171130182228.66czvzildgdeu6i4@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 10:10:03AM +0100, Marek Szyprowski wrote:
> Enable following drivers for recently merged devices:
> - perf events and ARM PMU (Performance Measurement Unit) driver for all
>   Exynos boards
> - CEC and S5P CEC driver for all Exynos4 and Exynos5 boards with HDMI
> - Sii9234 DRM HDMI-MHL bridge for Trats2
> - dedicated Odroid ASoC machine driver for Odroid XU3/XU4
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

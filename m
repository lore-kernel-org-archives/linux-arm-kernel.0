From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 30 Nov 2017 19:22:42 +0100
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable missing drivers for
 supported Exynos boards
In-Reply-To: <20171130091004.22971-2-m.szyprowski@samsung.com>
References: <20171130091004.22971-1-m.szyprowski@samsung.com>
 <CGME20171130091009eucas1p195871b12e598293afca3c74861b8c5ac@eucas1p1.samsung.com>
 <20171130091004.22971-2-m.szyprowski@samsung.com>
Message-ID: <20171130182242.fozfzan72bjr7bwn@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 10:10:04AM +0100, Marek Szyprowski wrote:
> Enable following drivers for recently merged devices:
> - CEC and S5P CEC driver for all Exynos4 and Exynos5 boards with HDMI
> - Sii9234 DRM HDMI-MHL bridge for Trats2
> - dedicated Odroid ASoC machine driver for Odroid XU3/XU4
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof

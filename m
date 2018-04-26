From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 26 Apr 2018 10:05:06 +0900
Subject: [RFC 03/10] cpufreq: exynos: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-4-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203335epcas5p3bfd2172f68574b67818c1d2bc74041bb@epcas5p3.samsung.com>
 <20180424203239.21885-4-krzk@kernel.org>
Message-ID: <5AE125C2.70105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2018? 04? 25? 05:32, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/cpufreq/cpufreq-exynos5440.txt        |  28 --
>  drivers/cpufreq/Kconfig.arm                        |  14 -
>  drivers/cpufreq/Makefile                           |   1 -
>  drivers/cpufreq/exynos5440-cpufreq.c               | 452 ---------------------
>  4 files changed, 495 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
>  delete mode 100644 drivers/cpufreq/exynos5440-cpufreq.c
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

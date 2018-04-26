From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 26 Apr 2018 09:58:41 +0900
Subject: [RFC 04/10] clk: samsung: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-5-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <CGME20180424203341epcas5p3a6db7d58b0ce8940d03711823fbf6e41@epcas5p3.samsung.com>
 <20180424203239.21885-5-krzk@kernel.org>
Message-ID: <5AE12441.2090506@samsung.com>
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
>  .../devicetree/bindings/clock/exynos5440-clock.txt |  28 ----
>  drivers/clk/samsung/Makefile                       |   1 -
>  drivers/clk/samsung/clk-exynos5440.c               | 167 ---------------------
>  include/dt-bindings/clock/exynos5440.h             |  44 ------
>  4 files changed, 240 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/exynos5440-clock.txt
>  delete mode 100644 drivers/clk/samsung/clk-exynos5440.c
>  delete mode 100644 include/dt-bindings/clock/exynos5440.h
> 

Looks good to me. Thanks.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

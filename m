From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 09:40:30 +0200
Subject: [PATCH v9 09/20] PM / devfreq: exynos: Remove unused exynos4/5
 busfreq driver
In-Reply-To: <1460347078-15175-10-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-10-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CA66E.5090409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
> This patch removes the unused exynos4/5 busfreq driver. Instead,
> generic exynos-bus frequency driver support the all Exynos SoCs.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/Kconfig              |   22 -
>  drivers/devfreq/Makefile             |    2 -
>  drivers/devfreq/exynos/Makefile      |    3 -
>  drivers/devfreq/exynos/exynos4_bus.c | 1055 ----------------------------------
>  drivers/devfreq/exynos/exynos4_bus.h |  110 ----
>  drivers/devfreq/exynos/exynos5_bus.c |  431 --------------
>  drivers/devfreq/exynos/exynos_ppmu.c |  119 ----
>  drivers/devfreq/exynos/exynos_ppmu.h |   86 ---
>  8 files changed, 1828 deletions(-)
>  delete mode 100644 drivers/devfreq/exynos/Makefile
>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.h
>  delete mode 100644 drivers/devfreq/exynos/exynos5_bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.h

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

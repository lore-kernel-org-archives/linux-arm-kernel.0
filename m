From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 13 Nov 2015 19:08:04 +0900
Subject: [PATCH v5 7/9] ARM: EXYNOS: split up exynos5420 SoC specific PMU
 data
In-Reply-To: <1447406983-27835-8-git-send-email-pankaj.dubey@samsung.com>
References: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
 <1447406983-27835-8-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5645B684.5000102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.11.2015 18:29, Pankaj Dubey wrote:
> This patch splits up mach-exynos/pmu.c file, and moves exynos5420,
> PMU configuration data and functions handing data into exynos5420
> SoC specific PMU file mach-exynos/exynos5420-pmu.c.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile         |   2 +-
>  arch/arm/mach-exynos/exynos-pmu.h     |   1 +
>  arch/arm/mach-exynos/exynos5420-pmu.c | 280 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/pmu.c            | 263 -------------------------------
>  4 files changed, 282 insertions(+), 264 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/exynos5420-pmu.c
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

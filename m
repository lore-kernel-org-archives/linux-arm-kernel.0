From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 03 Nov 2015 11:07:51 +0900
Subject: [PATCH v3 5/7] ARCH: EXYNOS: split up exynos5250 SoC specific PMU
 data
In-Reply-To: <1445864143-25695-6-git-send-email-pankaj.dubey@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <1445864143-25695-6-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <563816F7.10502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.10.2015 21:55, Pankaj Dubey wrote:
> This patch splits up mach-exynos/pmu.c file, and moves exynos5250,
> PMU configuration data and functions handing data into exynos5250
> SoC specific PMU file mach-exynos/exynos5250-pmu.c.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile         |   4 +-
>  arch/arm/mach-exynos/exynos-pmu.h     |   1 +
>  arch/arm/mach-exynos/exynos5250-pmu.c | 196 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/pmu.c            | 180 -------------------------------
>  4 files changed, 200 insertions(+), 181 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/exynos5250-pmu.c
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

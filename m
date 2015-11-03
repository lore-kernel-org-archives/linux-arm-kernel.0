From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 03 Nov 2015 10:37:23 +0900
Subject: [PATCH v3 1/7] ARM: EXYNOS: removing redundant code from
 regs-pmu.h
In-Reply-To: <1445864143-25695-2-git-send-email-pankaj.dubey@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <1445864143-25695-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56380FD3.1060204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.10.2015 21:55, Pankaj Dubey wrote:
> commit 6ec4f8d0d91f ("ARM: EXYNOS: add generic function to calculate
> cpu number") introduced exynos_pmu_cpunr to be used by multi-cluster SoC's
> e.g Exynos5420, but it's no more used in the codebase and hence removing
> this part of code.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/pmu.c      | 1 +
>  arch/arm/mach-exynos/regs-pmu.h | 9 ---------
>  2 files changed, 1 insertion(+), 9 deletions(-)
>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

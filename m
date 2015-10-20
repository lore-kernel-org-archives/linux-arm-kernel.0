From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 20 Oct 2015 09:13:46 +0900
Subject: [PATCH v4 8/8] ARM: EXYNOS: Remove SROM related register settings
 from mach-exynos
In-Reply-To: <1445255206-11148-9-git-send-email-pankaj.dubey@samsung.com>
References: <1445255206-11148-1-git-send-email-pankaj.dubey@samsung.com>
 <1445255206-11148-9-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5625873A.6020900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.10.2015 20:46, Pankaj Dubey wrote:
> As now we have dedicated driver for SROM controller, it will take care
> of saving register banks during S2R so we can safely remove these
> settings from mach-exynos.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                 |  2 ++
>  arch/arm/mach-exynos/exynos.c                | 17 ---------
>  arch/arm/mach-exynos/include/mach/map.h      |  3 --
>  arch/arm/mach-exynos/regs-srom.h             | 53 ----------------------------
>  arch/arm/mach-exynos/suspend.c               | 20 ++---------
>  arch/arm/plat-samsung/include/plat/map-s5p.h |  1 -
>  6 files changed, 4 insertions(+), 92 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/regs-srom.h
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

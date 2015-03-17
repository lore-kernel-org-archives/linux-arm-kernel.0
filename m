From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 18 Mar 2015 02:33:53 +0900
Subject: [PATCH v4 1/3] ARM: EXYNOS: Add missing static to file-scope
 declarations
In-Reply-To: <1426072121-6822-1-git-send-email-k.kozlowski@samsung.com>
References: <1426072121-6822-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <55086581.3010106@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/15 20:08, Krzysztof Kozlowski wrote:
> The 'pm_data', 'exynos_release_ret_regs', 'exynos3250_release_ret_regs'
> and 'exynos5420_release_ret_regs' are not exported nor used outside of
> suspend.c file. Make them static.
> 
> This fixes following sparse warnings:
> arch/arm/mach-exynos/suspend.c:83:23: warning: symbol 'pm_data' was not declared. Should it be static?
> arch/arm/mach-exynos/suspend.c:106:14: warning: symbol 'exynos_release_ret_regs' was not declared. Should it be static?
> arch/arm/mach-exynos/suspend.c:117:14: warning: symbol 'exynos5420_release_ret_regs' was not declared. Should it be static?
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---

Applied this whole series.

Thanks,
Kukjin

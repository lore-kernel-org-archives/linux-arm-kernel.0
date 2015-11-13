From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 13 Nov 2015 19:09:06 +0900
Subject: [PATCH v5 8/9] ARM: EXYNOS: rearrange static and non-static
 functions of PMU driver
In-Reply-To: <1447406983-27835-9-git-send-email-pankaj.dubey@samsung.com>
References: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
 <1447406983-27835-9-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <5645B6C2.9070307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.11.2015 18:29, Pankaj Dubey wrote:
> This patch moves exynos_sys_powerdown_conf function above all
> static functions, to avoid confusion causing due to mixing of
> static-nonstatic-static functions and to improve readability of this
> driver.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/mach-exynos/pmu.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

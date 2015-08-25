From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 25 Aug 2015 09:55:38 +0900
Subject: [PATCH v2 1/7] ARM: EXYNOS: remove unused static mapping of CMU
 for exynos5
In-Reply-To: <1440403348-8974-2-git-send-email-pankaj.dubey@samsung.com>
References: <1440403348-8974-1-git-send-email-pankaj.dubey@samsung.com>
 <1440403348-8974-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <55DBBD0A.1020805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.08.2015 17:02, Pankaj Dubey wrote:
> Remove unused static mapping of exynos5 CMU and related code.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c           | 5 -----
>  arch/arm/mach-exynos/include/mach/map.h | 1 -
>  2 files changed, 6 deletions(-)

Looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

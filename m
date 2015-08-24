From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 24 Aug 2015 16:17:18 +0900
Subject: [PATCH 07/18] ARM: EXYNOS: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-8-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
 <1440390978-22796-8-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <55DAC4FE.9090305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.08.2015 13:36, Masahiro Yamada wrote:
> The smp_operations structure is not over-written, so add const
> qualifier and replace __initdata with __initconst.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/mach-exynos/common.h  | 2 +-
>  arch/arm/mach-exynos/platsmp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Jun 2016 13:17:18 +0200
Subject: [[PATCH v2] 05/11] ARM: EXYNOS: Enable ARCH_SUPPORTS_BIG_ENDIAN
 explicitly
In-Reply-To: <1466504432-24187-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-6-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5769223E.4020309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 12:20 PM, Ben Dooks wrote:
> Now the initial fixes have the big-endian code working on EXYNOS, make sure
> we explicitly mark our arch as being big endian capable.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mach-exynos/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index e65aa7d..14906bf 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -13,6 +13,7 @@ menuconfig ARCH_EXYNOS
>  	select ARCH_HAS_BANDGAP
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	select ARCH_REQUIRE_GPIOLIB
> +	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ARM_AMBA
>  	select ARM_GIC
>  	select COMMON_CLK_SAMSUNG

I'll wait with this one till other patches get in.

Best regards,
Krzysztof

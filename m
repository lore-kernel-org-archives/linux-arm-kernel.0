From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 23 Oct 2015 11:14:15 +0900
Subject: [PATCHv2] ARM: dts: change the compatible from exynos5250 to
 exynos5420 for mshc
In-Reply-To: <1445565713-4000-1-git-send-email-jh80.chung@samsung.com>
References: <1445565713-4000-1-git-send-email-jh80.chung@samsung.com>
Message-ID: <562997F7.3060803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.10.2015 11:01, Jaehoon Chung wrote:
> Exynos3250 and exnos5250 are some differences in Mobile Storage Host.
> (For example, exynos3250 support the HS400 mode, but exynos5250 doesn't
> support it.)
> Exynos3250 can perform the similar function with exynos5420 compatible.
> So this patch changes the compatible from exynos5250 to exynos5420
> for mshc.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog v2:
> 	- Drop "mmc: dw_mmc: exynos: Add the exynos3250 compatible" patch.
> 	- Describe commit-message more detailedly than before.
> 	- Change to exynos5420, not add new compatible (exynos3250).
> 
>  arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Thanks! Looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

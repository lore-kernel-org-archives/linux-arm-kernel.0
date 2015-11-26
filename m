From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Nov 2015 16:35:07 +0900
Subject: [PATCH] ARM: dts: exynos4210: Add power domain to G2D device
In-Reply-To: <1448456127-31842-2-git-send-email-m.szyprowski@samsung.com>
References: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
 <1448456127-31842-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5656B62B.4090304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.11.2015 21:55, Marek Szyprowski wrote:
> G2D device and it's SYSMMU belongs to LCD0 power domain on Exynos 4210,
> so add missing power-domains property to G2D device node (G2D's SYSMMU is
> already bound to LCD0 power domain).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

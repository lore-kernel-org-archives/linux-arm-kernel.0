From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 Nov 2015 15:58:45 +0900
Subject: [PATCH v2 1/4] ARM: dts: exynos4210: MDMA1 device belongs to LCD0
 power domain
In-Reply-To: <1448542190-19498-2-git-send-email-m.szyprowski@samsung.com>
References: <1448542190-19498-1-git-send-email-m.szyprowski@samsung.com>
 <1448542190-19498-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <565BF3A5.30103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.11.2015 21:49, Marek Szyprowski wrote:
> On Exynos 4210 MDMA1 device belongs to LCD0 power domain, so add proper
> power-domains property. On Exynos 4x12, it belongs to TOP power domain,
> which is always enabled, thus require no assignment in exynos4x12.dtsi.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Makes sense. I suppose the rest of the patchset does not depends on it
directly so it can go through samsung-soc tree (otherwise please let us
know).

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

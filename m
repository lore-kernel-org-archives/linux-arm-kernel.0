From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 28 Jan 2016 16:16:21 -0300
Subject: [PATCH v4 3/3] arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol
 into ARCH_EXYNOS
In-Reply-To: <1453941324-15742-4-git-send-email-k.kozlowski@samsung.com>
References: <1453941324-15742-1-git-send-email-k.kozlowski@samsung.com>
 <1453941324-15742-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56AA6905.10807@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/27/2016 09:35 PM, Krzysztof Kozlowski wrote:
> The ARMv8 Exynos family SoCs in Linux kernel are currently:
>   - Exynos5433 (controlled by ARCH_EXYNOS),
>   - Exynos7 (controlled by ARCH_EXYNOS7).
>
> It duplicates Kconfig symbols unnecessarily, so consolidate them into
> one ARCH_EXYNOS. Future SoCs could fall also under the ARCH_EXYNOS
> symbol.
>
> The commit should not bring any visible functional change.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
>

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

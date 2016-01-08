From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 8 Jan 2016 12:32:53 -0300
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable NEON, accelerated
 crypto and cpufreq stats
In-Reply-To: <1452132905-8587-1-git-send-email-k.kozlowski@samsung.com>
References: <1452132905-8587-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <568FD6A5.9020409@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/06/2016 11:15 PM, Krzysztof Kozlowski wrote:
> Enable the kernel NEON mode and asm/NEON accelerated crypto algorithms
> which should bring performance benefits on Exynos SoCs. Enable these as
> modules because they are optional, not essential anyhow for platform
> booting nor related directly to Exynos Soc. All accelerated algorithms
> pass booting self-tests on Odroid XU4 (Exynos5422) and Trats2 (Exynos4412).
> 
> Additionally enable cpufreq statistics as they are useful for debugging.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

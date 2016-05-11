From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 11 May 2016 10:11:50 -0400
Subject: [PATCH 1/2] ARM: EXYNOS: Move pm_domains driver to
 drivers/soc/samsung
In-Reply-To: <1462888341-21963-1-git-send-email-k.kozlowski@samsung.com>
References: <1462888341-21963-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <61ec0a28-1b40-d66e-d349-f40463bd1637@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/10/2016 09:52 AM, Krzysztof Kozlowski wrote:
> Exynos PM domains driver does not have mach-specific dependencies so it
> can be safely moved out of arm/mach-exynos to drivers/soc. This in
> future will allow re-using it on ARM64 boards.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

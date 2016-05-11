From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 11 May 2016 10:13:09 -0400
Subject: [PATCH 2/2] soc: samsung: pm_domains: Prepare for supporting
 ARMv8 Exynos
In-Reply-To: <1462888341-21963-2-git-send-email-k.kozlowski@samsung.com>
References: <1462888341-21963-1-git-send-email-k.kozlowski@samsung.com>
 <1462888341-21963-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <7a62ff75-187e-06ef-8331-c056a7eee4e7@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/10/2016 09:52 AM, Krzysztof Kozlowski wrote:
> The ARMv8 Exynos family (Exynos5433 and Exynos7420) uses different value
> (0xf instead of 0x7) for controlling the power domain on/off registers
> (both for control and for status).
> 
> Choose the value depending on the compatible. This prepares the driver
> for supporting ARMv8 SoCs.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

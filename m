From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 15:53:11 -0400
Subject: [PATCH v2 03/22] ARM: dts: exynos: Add fin_pll node for clock
 driver
In-Reply-To: <1462734367-5619-4-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-4-git-send-email-krzk@kernel.org>
Message-ID: <978d6aba-e177-ee0a-2a6b-782a7e962646@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:05 PM, Krzysztof Kozlowski wrote:
> For consistency between Exynos5410 and Exynos542x/5800 switch to similar
> way of defining fin_pll/oscclk. Add a node early, before implementing
> this in driver to preserve bisectability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

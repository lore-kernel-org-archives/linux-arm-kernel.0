From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 16:50:58 -0400
Subject: [PATCH v2 08/22] clk: samsung: exynos5410: Add serial3, USB and
 PWM clocks
In-Reply-To: <1462734367-5619-9-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-9-git-send-email-krzk@kernel.org>
Message-ID: <7a1772c3-d81a-3133-d775-0e8034fcee9d@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:05 PM, Krzysztof Kozlowski wrote:
> Just like other Exynos5 family SoCs, this one has four UARTs. Add
> missing UART3 clocks to the Exynso5410 clock driver.
> 
> Add clocks for USB and PWM.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

I don't have an Exynos5410 SoC user manual to double check all values
but assuming that are correct, the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

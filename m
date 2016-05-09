From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 16:25:55 -0400
Subject: [PATCH v2 07/22] clk: samsung: exynos5410: Rename fin_pll from
 temporary to regular name
In-Reply-To: <1462734367-5619-8-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-8-git-send-email-krzk@kernel.org>
Message-ID: <50c533ac-9712-47b7-ef3f-87ef779be8e3@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:05 PM, Krzysztof Kozlowski wrote:
> For smooth transition of fin_pll to clk-exynos5410.c from fixed-clock
> driver, initially it was named "fin_pll_new". Fix this here.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

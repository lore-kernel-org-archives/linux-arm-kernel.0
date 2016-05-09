From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 16:22:01 -0400
Subject: [PATCH v2 05/22] ARM: dts: exynos: Switch MCT node to a new
 fin_pll clock
In-Reply-To: <1462734367-5619-6-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-6-git-send-email-krzk@kernel.org>
Message-ID: <9359df26-fc41-78da-dbf8-cc336dbe80da@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 03:05 PM, Krzysztof Kozlowski wrote:
> The clk-exynos5410 driver now provides the "fin_pll" external fixed
> clock. Switch the Multi-Core Timer to this clock.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

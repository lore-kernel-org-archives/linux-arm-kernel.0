From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 12:43:21 -0800
Subject: [PATCH v4 1/3] clk: samsung: Enable COMPILE_TEST for Samsung
 clocks
In-Reply-To: <1453941324-15742-2-git-send-email-k.kozlowski@samsung.com>
References: <1453941324-15742-1-git-send-email-k.kozlowski@samsung.com>
 <1453941324-15742-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160129204321.GS12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28, Krzysztof Kozlowski wrote:
> Enable the COMPILE_TEST to get build coverage of some of Samsung clock
> controller drivers. Still some of them will be built only if
> appropriate SoC is chosen (like SOC_EXYNOS4415 or ARCH_S3C64XX).
> 
> Anyway in case of COMPILE_TEST the Samsung clocks would show up in main
> drivers section because they are not inside the "Common Clock Framework"
> menu item. Move them under the "Common Clock Framework".
> 
> This changes the logic of selecting Samsung clocks from specific
> architectures. Now the COMMON_CLK should be selected before selecting
> specific clock (like S3C2410_COMMON_CLK or COMMON_CLK_SAMSUNG).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 12:43:32 -0800
Subject: [PATCH v4 2/3] clk: samsung: Don't build ARMv8 clock drivers on
 ARMv7
In-Reply-To: <1453941324-15742-3-git-send-email-k.kozlowski@samsung.com>
References: <1453941324-15742-1-git-send-email-k.kozlowski@samsung.com>
 <1453941324-15742-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160129204332.GT12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28, Krzysztof Kozlowski wrote:
> Currently the Exynos5433 (ARMv8 SoC) clock driver depends on ARCH_EXYNOS
> so it is built also on ARMv7. This does not bring any kind of benefit.
> There won't be a single kernel image for ARMv7 and ARMv8 SoCs (like
> multi_v7 for ARMv7).
> 
> Instead build clock drivers only for respective SoC's architecture.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

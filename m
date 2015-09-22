From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 22 Sep 2015 10:09:43 -0700
Subject: [PATCH v2] clk: samsung: fix cpu clock's flags checking
In-Reply-To: <1440762575-21520-1-git-send-email-b.zolnierkie@samsung.com>
References: <1440762575-21520-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150922170943.GI23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28, Bartlomiej Zolnierkiewicz wrote:
> CLK_CPU_HAS_DIV1 and CLK_CPU_NEEDS_DEBUG_ALT_DIV masks were
> incorrectly used as a bit numbers.  Fix it.
> 
> Tested on Exynos4210 based Origen board and on Exynos5250 based
> Arndale board.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Fixes: ddeac8d96 ("clk: samsung: add infrastructure to register cpu clocks")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

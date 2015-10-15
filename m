From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Oct 2015 12:28:32 -0700
Subject: [PATCH 09/13] clk: versatile-icst: add device tree support
In-Reply-To: <1444916813-31024-10-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-10-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151015192832.GP4558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Linus Walleij wrote:
> This adds support for the ARM syscon ICST clocks to initialized
> directly from the device tree syscon node on ARM Integrator,
> Versatile and RealView reference designs.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Also:

WARNING: please, no space before tabs
#47: FILE: drivers/clk/versatile/clk-icst.c:221:
+^I.vd_min ^I= 8,$

WARNING: please, no space before tabs
#48: FILE: drivers/clk/versatile/clk-icst.c:222:
+^I.vd_max ^I= 263,$

WARNING: please, no space before tabs
#49: FILE: drivers/clk/versatile/clk-icst.c:223:
+^I.rd_min ^I= 3,$

WARNING: please, no space before tabs
#50: FILE: drivers/clk/versatile/clk-icst.c:224:
+^I.rd_max ^I= 65,$

total: 0 errors, 4 warnings, 98 lines checked

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

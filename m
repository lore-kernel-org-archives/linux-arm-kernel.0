From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 8 Aug 2017 18:43:12 -0700
Subject: [PATCH] clk: gemini: hands off PCI OE bit
In-Reply-To: <20170808190818.11740-1-linus.walleij@linaro.org>
References: <20170808190818.11740-1-linus.walleij@linaro.org>
Message-ID: <20170809014312.GZ2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08, Linus Walleij wrote:
> This bit is pin control, and needs to be carefully managed by the
> new pin control driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Fixes tag?

Does this need to be merged now as a critical fix? Or we can wait
on it for next release?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

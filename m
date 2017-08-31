From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Aug 2017 22:29:21 -0700
Subject: [PATCH] clk: gemini: hands off PCI OE bit
In-Reply-To: <20170808190818.11740-1-linus.walleij@linaro.org>
References: <20170808190818.11740-1-linus.walleij@linaro.org>
Message-ID: <20170831052921.GY21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08, Linus Walleij wrote:
> This bit is pin control, and needs to be carefully managed by the
> new pin control driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

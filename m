From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jun 2016 12:26:29 -0700
Subject: [PATCH 32/34] clk: u300: Migrate to clk_hw based registration APIs
In-Reply-To: <20160601231533.9354-33-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-33-stephen.boyd@linaro.org>
Message-ID: <20160630192629.GQ1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

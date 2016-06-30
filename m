From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jun 2016 12:26:03 -0700
Subject: [PATCH 20/34] clk: nomadik: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-21-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-21-stephen.boyd@linaro.org>
Message-ID: <20160630192603.GP1521@codeaurora.org>
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

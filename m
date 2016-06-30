From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jun 2016 12:28:26 -0700
Subject: [PATCH 30/34] clk: stm32f3: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-31-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-31-stephen.boyd@linaro.org>
Message-ID: <20160630192826.GS1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next + fixed subject

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Aug 2016 17:09:06 -0700
Subject: [PATCH 16/34] clk: ls1x: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-17-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-17-stephen.boyd@linaro.org>
Message-ID: <20160819000906.GN361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Kelvin Cheung <keguang.zhang@gmail.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next + a small fix to get it to compile

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

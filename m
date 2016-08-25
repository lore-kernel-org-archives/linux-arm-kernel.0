From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 17:27:06 -0700
Subject: [PATCH 18/34] clk: mb86s7x: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-19-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-19-stephen.boyd@linaro.org>
Message-ID: <20160825002706.GZ19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next, but this driver doesn't even compile in
mainline...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

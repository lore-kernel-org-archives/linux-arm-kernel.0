From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 16:11:01 -0700
Subject: [PATCH 09/34] clk: axi-clkgen: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-10-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-10-stephen.boyd@linaro.org>
Message-ID: <20160824231101.GL19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

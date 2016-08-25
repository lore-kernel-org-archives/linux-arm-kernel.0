From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 17:21:30 -0700
Subject: [PATCH 14/34] clk: cs2000: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-15-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-15-stephen.boyd@linaro.org>
Message-ID: <20160825002130.GT19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

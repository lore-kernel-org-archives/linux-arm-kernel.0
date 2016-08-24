From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 16:08:21 -0700
Subject: [PATCH 06/34] clk: bcm: kona: Migrate to clk_hw based
 registration and OF APIs
In-Reply-To: <20160601231533.9354-7-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-7-stephen.boyd@linaro.org>
Message-ID: <20160824230821.GI19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we can use clk_hw pointers we don't need to have two
> duplicate arrays holding the same mapping of clk index to clk_hw
> pointer. Implement a custom clk_hw provider function to map the
> OF specifier to the clk_hw instance for it.
> 
> Cc: Alex Elder <elder@linaro.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

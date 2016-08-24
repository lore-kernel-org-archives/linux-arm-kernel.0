From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 16:10:24 -0700
Subject: [PATCH 08/34] clk: asm9260: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <20160601231533.9354-9-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-9-stephen.boyd@linaro.org>
Message-ID: <20160824231024.GK19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Oleksij Rempel <linux@rempel-privat.de>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

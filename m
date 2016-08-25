From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 17:30:27 -0700
Subject: [PATCH 28/34] clk: si5351: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-29-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-29-stephen.boyd@linaro.org>
Message-ID: <20160825003027.GB19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Stephen Boyd wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
> 
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: Mike Looijmans <mike.looijmans@topic.nl>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Sep 2016 11:25:06 -0700
Subject: [PATCH 1/4] clk: gxbb: expose i2c clocks
In-Reply-To: <1473847568-20163-2-git-send-email-jbrunet@baylibre.com>
References: <1473847568-20163-1-git-send-email-jbrunet@baylibre.com>
 <1473847568-20163-2-git-send-email-jbrunet@baylibre.com>
Message-ID: <20160914182506.GS7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14, Jerome Brunet wrote:
> I2C and AO_I2C clocks are needed for the i2c driver, expose to DT
> (and comment out in clk driver)
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

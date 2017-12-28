From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 10:50:07 -0800
Subject: [RFC PATCH clk] clk: si5351: _si5351_clkout_reset_pll() can be
 static
In-Reply-To: <20171227042513.GA56372@ivb42>
References: <201712271259.pq3B6Kw4%fengguang.wu@intel.com>
 <20171227042513.GA56372@ivb42>
Message-ID: <20171228185007.GR7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/27, kbuild test robot wrote:
> 
> Fixes: b26ff127c52c ("clk: si5351: Apply PLL soft reset before enabling the outputs")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

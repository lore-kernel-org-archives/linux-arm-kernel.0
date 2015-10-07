From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Oct 2015 12:15:03 -0700
Subject: [PATCH v4 3/4] drivers: clk: st: Correct the pll-type for A9 for
 stih418
In-Reply-To: <1444208939-10233-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1444208939-10233-1-git-send-email-gabriel.fernandez@linaro.org>
 <1444208939-10233-4-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20151007191503.GC12345@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07, Gabriel Fernandez wrote:
> Add support for new PLL-type for stih418 A9-PLL.
> Currently the 407_A9_PLL type being used, it is corrected with this patch
> 4600c28 PLL allows to reach higher frequencies
> so its programming algorithm is extended.
> 
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Oct 2015 12:14:57 -0700
Subject: [PATCH v4 1/4] drivers: clk: st: Support for enable/disable in
 Clockgen PLLs
In-Reply-To: <1444208939-10233-2-git-send-email-gabriel.fernandez@linaro.org>
References: <1444208939-10233-1-git-send-email-gabriel.fernandez@linaro.org>
 <1444208939-10233-2-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20151007191456.GA12345@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07, Gabriel Fernandez wrote:
> The patch adds support for enable/disable of the Clockgen PLLs.
> clkgen_pll_enable/clkgen_pll_disable added as generic function for all PLLs.
> 
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

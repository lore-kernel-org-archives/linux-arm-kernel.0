From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Oct 2015 12:32:35 -0700
Subject: [PATCH v2 1/4] drivers: clk: st: Support for enable/disable in
 Clockgen PLLs
In-Reply-To: <1440409251-11166-2-git-send-email-gabriel.fernandez@linaro.org>
References: <1440409251-11166-1-git-send-email-gabriel.fernandez@linaro.org>
 <1440409251-11166-2-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20151002193234.GT12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Gabriel Fernandez wrote:
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

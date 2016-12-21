From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 15:34:57 -0800
Subject: [PATCH] clk: stm32f4: Use CLK_OF_DECLARE_DRIVER initialization
 method
In-Reply-To: <1481725348-860-1-git-send-email-gabriel.fernandez@st.com>
References: <1481725348-860-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161221233457.GG8288@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Clock and reset controller use same compatible strings (same IP).
> 
> Since commit 989eafd0b609 ("clk: core: Avoid double initialization of
> clocks") the OF core flags clock controllers registered with the
> CLK_OF_DECLARE() macro as OF_POPULATED, so platform devices with the same
> compatible string will not be registered.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

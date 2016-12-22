From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 16:11:02 -0800
Subject: [PATCH v4 3/9] clk: stm32f4: Add post divisor for I2S & SAI PLLs
In-Reply-To: <1481638820-29324-4-git-send-email-gabriel.fernandez@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
 <1481638820-29324-4-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161222001102.GR8288@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds post dividers of I2S & SAI PLLs.
> These dividers are managed by a dedicated register (RCC_DCKCFGR).
> The PLL should be off before a set rate.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-stm32f4 and merged into clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

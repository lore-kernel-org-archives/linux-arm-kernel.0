From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 16:10:57 -0800
Subject: [PATCH v4 2/9] clk: stm32f4: Add PLL_I2S & PLL_SAI for
 STM32F429/469 boards
In-Reply-To: <1481638820-29324-3-git-send-email-gabriel.fernandez@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
 <1481638820-29324-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161222001057.GQ8288@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch introduces PLL_I2S and PLL_SAI.
> Vco clock of these PLLs can be modify by DT (only n multiplicator,
> m divider is still fixed by the boot-loader).
> Each PLL has 3 dividers. PLL should be off when we modify the rate.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-stm32f4 and merged into clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

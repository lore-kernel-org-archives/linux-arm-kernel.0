From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 16:11:20 -0800
Subject: [PATCH v4 7/9] clk: stm32f4: SDIO & 48Mhz clock management for
 STM32F469 board
In-Reply-To: <1481638820-29324-8-git-send-email-gabriel.fernandez@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
 <1481638820-29324-8-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161222001120.GV8288@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> In the stm32f469 soc, the 48Mhz clock could be derived from pll-q or
> from pll-sai-p.
> 
> The SDIO clock could be also derived from 48Mhz or from sys clock.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-stm32f4 and merged into clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

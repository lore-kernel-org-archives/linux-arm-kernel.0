From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Dec 2016 16:10:51 -0800
Subject: [PATCH v4 1/9] clk: stm32f4: Update DT bindings documentation
In-Reply-To: <1481638820-29324-2-git-send-email-gabriel.fernandez@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
 <1481638820-29324-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161222001051.GP8288@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Creation of dt include file for specific stm32f4 clocks.
> These specific clocks are not derived from system clock (SYSCLOCK)
> We should use index 1 to use these clocks in DT.
> e.g. <&rcc 1 CLK_LSI>
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-stm32f4 and merged into clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

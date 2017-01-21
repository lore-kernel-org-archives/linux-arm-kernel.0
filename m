From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:34:58 -0800
Subject: [PATCH v2 1/3] dt-bindings: mfd: stm32f4: Fix STM32F4_X_CLOCK()
 macro
In-Reply-To: <1483952833-14704-2-git-send-email-gabriel.fernandez@st.com>
References: <1483952833-14704-1-git-send-email-gabriel.fernandez@st.com>
 <1483952833-14704-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170121003458.GW20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Macro to select a clock was not correct.
> 
> Offset of enable register starts at 0x30, then calculation to select a bit is:
> (@enable_reg - 0x30) / 4 * 32 + bit_to_select
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Tested-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

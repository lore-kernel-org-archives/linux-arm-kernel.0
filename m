From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 16:51:08 -0700
Subject: [PATCH v2 0/6] STM32F4 Add RTC & QSPI clocks
In-Reply-To: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161018235108.GP8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14, gabriel.fernandez at st.com wrote:
> 
> Gabriel Fernandez (6):
>   clk: stm32f4: Add LSI & LSE clocks
>   ARM: dts: stm32f429: add LSI and LSE clocks
>   arm: stmf32: Enable SYSCON
>   clk: stm32f4: Add RTC clock
>   clk: stm32f469: Add QSPI clock
>   ARM: dts: stm32f429: Add QSPI clock

Can the clk patches be picked without causing problems for
existing dt changes? Do you want an ack from clk maintainers
instead of us picking the clk patches up? The series has
intermingled clk and dts changes so I'm confused.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

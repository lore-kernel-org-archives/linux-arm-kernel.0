From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Oct 2016 18:39:40 -0700
Subject: [PATCH v3 3/3] clk: stm32f469: Add QSPI clock
In-Reply-To: <1477041810-12313-4-git-send-email-gabriel.fernandez@st.com>
References: <1477041810-12313-1-git-send-email-gabriel.fernandez@st.com>
 <1477041810-12313-4-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161028013940.GC16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds the QSPI clock for stm32f469 discovery board.
> The gate mapping is a little bit different from stm32f429 soc.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next + added Rob's ack from v2.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

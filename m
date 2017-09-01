From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 31 Aug 2017 18:36:39 -0700
Subject: [RESEND PATCH v8 1/3] clk: nxp: clk-lpc32xx: rename
 clk_gate_is_enabled()
In-Reply-To: <1503316742-22145-2-git-send-email-gabriel.fernandez@st.com>
References: <1503316742-22145-1-git-send-email-gabriel.fernandez@st.com>
 <1503316742-22145-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170901013639.GP21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> We need to export clk_gate_is_enabled() from clk framework, then
> to avoid compilation issue we have to rename clk_gate_is_enabled()
> in NXP LPC32xx clock driver.
> We changed all gate op with 'lpc32xx_' prefix:
> lpc32xx_clk_gate_enable(),
> lpc32xx_clk_gate_disable(),
> lpc32xx_clk_gate_is_enabled().
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

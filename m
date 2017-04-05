From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 5 Apr 2017 14:52:26 -0700
Subject: [PATCH v2 2/2] clk: stm32f4: fix timeout management for pll and
 ready gate
In-Reply-To: <1489652201-19889-3-git-send-email-gabriel.fernandez@st.com>
References: <1489652201-19889-1-git-send-email-gabriel.fernandez@st.com>
 <1489652201-19889-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170405215226.GG7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Use a classic polling to test bit ready.
> And the shift of the bit ready of LSE & LSI were wrongs.
> 
> Fixes: 861adc44d290 ("clk: stm32f4: Add LSI & LSE clocks")
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 31 Aug 2017 18:36:42 -0700
Subject: [RESEND PATCH v8 2/3] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <1503316742-22145-3-git-send-email-gabriel.fernandez@st.com>
References: <1503316742-22145-1-git-send-email-gabriel.fernandez@st.com>
 <1503316742-22145-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170901013642.GQ21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch exposes clk_gate_ops::is_enabled as functions
> that can be directly called and assigned in places like this so
> we don't need wrapper functions that do nothing besides forward
> the call.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

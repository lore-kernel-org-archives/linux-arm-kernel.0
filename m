From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Jun 2015 14:23:19 -0700
Subject: [PATCH] clk: Move debug_node field under DEBUG_FS flag in struct
 clk_core
In-Reply-To: <1433935707-3621-1-git-send-email-maxime.coquelin@st.com>
References: <1433935707-3621-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <20150610212319.GD29640@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10, Maxime Coquelin wrote:
> The debug_node field is only used when DEBUG_FS config is selected,
> so declare it only if DEBUG_FS is selected.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

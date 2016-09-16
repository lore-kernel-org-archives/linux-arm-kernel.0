From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Sep 2016 16:02:57 -0700
Subject: [PATCH v3 02/14] drivers: clk: st: Simplify clock binding of
 STiH4xx platforms
In-Reply-To: <1472473626-15398-3-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
 <1472473626-15398-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20160916230257.GO7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch reworks the clock binding to avoid too much detail in DT.
> Now we have only compatible string per type of clock
> (remark from Rob https://lkml.org/lkml/2016/5/25/492)
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 18:41:33 -0700
Subject: [PATCH v3] clk: mediatek: Initialize clk_init_data
In-Reply-To: <1431957632-2182-1-git-send-email-jcliang@chromium.org>
References: <1431957632-2182-1-git-send-email-jcliang@chromium.org>
Message-ID: <20150520014133.GE31054@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18, Ricky Liang wrote:
> The variable init (struct clk_init_data) is allocated on the stack.
> We weren't initializing the .flags field, so it contains random junk,
> which can cause all kinds of interesting issues when the flags are
> parsed by clk_register.
> 
> Signed-off-by: Ricky Liang <jcliang@chromium.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

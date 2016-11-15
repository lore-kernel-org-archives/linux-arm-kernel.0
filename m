From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Nov 2016 18:41:00 -0800
Subject: [PATCH 1/3] clk: Hi6220: enable stub clock driver for ARCH_HISI
In-Reply-To: <1472633417-9330-2-git-send-email-leo.yan@linaro.org>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
 <1472633417-9330-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20161115024100.GW5177@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31, Leo Yan wrote:
> In current kernel config 'CONFIG_STUB_CLK_HI6220' is disabled by
> default, as result stub clock driver has not been registered and
> CPUFreq driver cannot work.
> 
> This patch is to enable stub clock driver in config for ARCH_HISI.
> 
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 17:00:57 -0700
Subject: [PATCH] clk: Fix return value check in oxnas_stdclk_probe()
In-Reply-To: <1466184263-17890-1-git-send-email-weiyj_lk@163.com>
References: <1466184263-17890-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20160621000057.GC1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function syscon_node_to_regmap() returns
> ERR_PTR() and never returns NULL. The NULL test in the return
> value check should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---

Applied to clk-fixes + added fixes tag.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

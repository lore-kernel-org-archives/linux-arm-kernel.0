From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 10:42:26 -0800
Subject: [PATCH -next] clk: meson-axg: fix return value check in
 axg_clkc_probe()
In-Reply-To: <1514428849-61681-1-git-send-email-weiyongjun1@huawei.com>
References: <1514428849-61681-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20171228184226.GO7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28, Wei Yongjun wrote:
> In case of error, the function devm_ioremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: 78b4af312f91 ("clk: meson-axg: add clock controller drivers")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

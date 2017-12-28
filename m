From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 10:42:24 -0800
Subject: [PATCH -next] clk: meson-axg: make local symbol
 axg_gp0_params_table static
In-Reply-To: <1514431110-98277-1-git-send-email-weiyongjun1@huawei.com>
References: <1514431110-98277-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20171228184224.GN7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> drivers/clk/meson/axg.c:260:25: warning:
>  symbol 'axg_gp0_params_table' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

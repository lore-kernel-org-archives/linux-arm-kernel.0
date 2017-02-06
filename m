From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Feb 2017 15:01:31 -0800
Subject: [PATCH -next] clk: sunxi-ng: sun9i-a80: Fix wrong pointer passed
 to PTR_ERR()
In-Reply-To: <20170206160926.8274-1-weiyj.lk@gmail.com>
References: <20170206160926.8274-1-weiyj.lk@gmail.com>
Message-ID: <20170206230131.GL25384@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
> 
> Fixes: 783ab76ae553 ("clk: sunxi-ng: Add A80 Display Engine CCU")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

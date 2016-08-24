From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 10:29:44 -0700
Subject: [PATCH -next] clk: meson: Fix invalid use of sizeof in
 gxbb_aoclkc_probe()
In-Reply-To: <1471882101-22347-1-git-send-email-weiyj.lk@gmail.com>
References: <1471882101-22347-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160824172944.GA19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> sizeof() when applied to a pointer typed expression gives the
> size of the pointer, not that of the pointed data.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

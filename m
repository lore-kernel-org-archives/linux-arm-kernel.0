From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 4 Apr 2017 14:51:09 -0700
Subject: [PATCH v5 7/9] clk: hi6220: add debug APB clock
In-Reply-To: <1490466197-29163-8-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-8-git-send-email-leo.yan@linaro.org>
Message-ID: <20170404215109.GH18246@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26, Leo Yan wrote:
> The debug APB clock is absent in hi6220 driver, so this patch is to add
> support for it.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Applied to clk-next. I suspect we don't need a topic branch for
the DT header because arm-soc won't be taking the dts side of the
changes?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

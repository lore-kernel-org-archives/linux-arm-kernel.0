From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 3 Aug 2015 14:46:03 -0700
Subject: [PATCH v3 1/5] clk: hisi: refine parameter checking for init
In-Reply-To: <1438564418-15948-2-git-send-email-leo.yan@linaro.org>
References: <1438564418-15948-1-git-send-email-leo.yan@linaro.org>
 <1438564418-15948-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20150803214603.GC21068@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03, Leo Yan wrote:
> *of_iomap()* will check the device node pointer, and if the pointer is
> NULL it will return error code. So refine clock's init flow by checking
> the device node with this simple way; and polish a little for the print
> out message.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

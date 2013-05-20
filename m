From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 May 2013 14:16:42 -0700
Subject: [PATCH v4 2/5] clk: move some parent related functions upwards
In-Reply-To: <1369056507-32521-3-git-send-email-james.hogan@imgtec.com>
References: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
 <1369056507-32521-3-git-send-email-james.hogan@imgtec.com>
Message-ID: <519A92BA.1090702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/13 06:28, James Hogan wrote:
> Move some parent related functions up in clk.c so they can be used by
> the modifications in the following patch which enables clock reparenting
> during set_rate. No other changes are made so this patch makes no
> functional difference in isolation. This is separate from the following
> patch primarily to ease readability of that patch.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

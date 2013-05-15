From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 May 2013 13:25:23 -0700
Subject: [PATCH v3 1/4] clk: abstract parent cache
In-Reply-To: <1368625263-23136-2-git-send-email-james.hogan@imgtec.com>
References: <1368625263-23136-1-git-send-email-james.hogan@imgtec.com>
 <1368625263-23136-2-git-send-email-james.hogan@imgtec.com>
Message-ID: <5193EF33.9000903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/13 06:41, James Hogan wrote:
> Abstract access to the clock parent cache by defining
> clk_get_parent_by_index(clk, index). This allows access to parent
> clocks from clock drivers.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

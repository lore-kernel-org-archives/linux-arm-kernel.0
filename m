From: agross@codeaurora.org (Andy Gross)
Date: Fri, 5 Dec 2014 15:40:02 -0600
Subject: [PATCH] ARM: dts: qcom: Correct IPQ tlmm interrupt
In-Reply-To: <1417812813-12804-1-git-send-email-sboyd@codeaurora.org>
References: <1417812813-12804-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20141205214002.GB14438@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 12:53:33PM -0800, Stephen Boyd wrote:
> The interrupt is 16, not 32 (which it would be if we include PPIs
> in the count of interrupts).
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

This fixed my issue!

Reviewed-by: Andy Gross <agross@codeaurora.org>
Tested-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

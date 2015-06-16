From: agross@codeaurora.org (Andy Gross)
Date: Tue, 16 Jun 2015 15:31:28 -0500
Subject: [PATCH] regulator: qcom_spmi: Add missing braces for aligned code
In-Reply-To: <1434478282-13552-1-git-send-email-sboyd@codeaurora.org>
References: <1434478282-13552-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150616203128.GA8507@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 11:11:22AM -0700, Stephen Boyd wrote:
> drivers/regulator/qcom_spmi-regulator.c:751:3-50: code aligned
> with following code on line 753
> drivers/regulator/qcom_spmi-regulator.c:584:3-41: code aligned
> with following code on line 587
> 
> These lines where missing braces causing the break to always
> be executed even when it shouldn't be. Fix it.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

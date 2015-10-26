From: agross@codeaurora.org (Andy Gross)
Date: Sun, 25 Oct 2015 21:00:14 -0500
Subject: [PATCH v3 3/4] soc: qcom: smd: Use __ioread32_copy() instead of
 open-coding it
In-Reply-To: <1445630512-10888-4-git-send-email-sboyd@codeaurora.org>
References: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
 <1445630512-10888-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151026020014.GA5705@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 01:01:51PM -0700, Stephen Boyd wrote:
> Now that we have a generic library function for this, replace the
> open-coded instance.
> 
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Acked-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

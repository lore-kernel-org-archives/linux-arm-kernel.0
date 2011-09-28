From: davidb@codeaurora.org (David Brown)
Date: Wed, 28 Sep 2011 16:50:21 -0700
Subject: [PATCH 1/2] msm: Consolidate and move DEBUG_LL to generic ARM
	Kconfig
In-Reply-To: <1317243959-26383-2-git-send-email-sboyd@codeaurora.org>
References: <1317243959-26383-1-git-send-email-sboyd@codeaurora.org>
	<1317243959-26383-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110928235021.GA10636@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 02:05:58PM -0700, Stephen Boyd wrote:
> Now that DEBUG_LL is a choice, we can move MSM's homegrown choice
> menu to DEBUG_LL.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

This seems to make DEBUG_LL work again on MSM8250.  So:

Tested-by: David Brown <davidb@codeaurora.org>

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

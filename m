From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 13 Nov 2017 13:19:02 -0600
Subject: [PATCH 0/4] [v7] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
Message-ID: <c219c289-9cad-f96c-f766-ec28af8f078d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2017 05:07 PM, Timur Tabi wrote:
> A series of patches that add support for GPIO maps that have holes in
> them.  That is, even though a client driver has N consecutive GPIOs,
> some are just unavailable for whatever reason, and the hardware should
> not be accessed for those GPIOs.

Any chance of these patches going into 4.15?  I've been making lots of 
changes, but I haven't gotten a lot of feedback.  I still think that v7 
is more intrusive and risky than v5, with no real benefit.  But at this 
point, I just want something to be merged so that I stop thinking about it.



-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

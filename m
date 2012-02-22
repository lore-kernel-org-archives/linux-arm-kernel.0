From: davidb@codeaurora.org (David Brown)
Date: Wed, 22 Feb 2012 13:55:33 -0800
Subject: [PATCH] msm: timer: Support sched_clock()
In-Reply-To: <1329874777-12758-1-git-send-email-sboyd@codeaurora.org>
References: <1329874777-12758-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120222215533.GA31480@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 05:39:37PM -0800, Stephen Boyd wrote:
> Now that sched_clock is mandatory on ARM it's simple to add
> sched_clock support to the MSM timer code. Add it so that we get
> more accurate sched_clock output than the jiffies based version
> that's provided by default.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: David Brown <davidb@codeaurora.org>

Marc, are you able to pull this into your series, so they can all go
in together?  If so:

  Acked-by: David Brown <davidb@codeaurora.org>

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

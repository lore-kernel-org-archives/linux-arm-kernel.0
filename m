From: davidb@codeaurora.org (David Brown)
Date: Fri, 13 Jan 2012 14:37:40 -0800
Subject: [PATCH v2 14/15] ARM: local timers: convert MSM to runtime
 registration interface
In-Reply-To: <1326479322-6033-15-git-send-email-marc.zyngier@arm.com>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
 <1326479322-6033-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120113223740.GA23036@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 06:28:41PM +0000, Marc Zyngier wrote:
> Convert the MSM timers to the runtime registration interface.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Tested-by: David Brown <davidb@codeaurora.org>
> Acked-by: David Brown <davidb@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Ok, this is definitely now consistenly causing cpu hotplug to fail.
I'll look in to this further, but for now, please removed my Tested-by
and Acked-by.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

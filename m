From: davidb@codeaurora.org (David Brown)
Date: Fri, 13 Jan 2012 15:26:59 -0800
Subject: [PATCH v2 14/15] ARM: local timers: convert MSM to runtime
 registration interface
In-Reply-To: <1326479322-6033-15-git-send-email-marc.zyngier@arm.com>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
 <1326479322-6033-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120113232659.GA20638@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 06:28:41PM +0000, Marc Zyngier wrote:

> +static struct local_timer_ops msm_local_timer_ops __initdata = {

This needs to be __cpuinitdata.  With that change, you can put the
tested and acked-by back.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

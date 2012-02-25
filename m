From: davidb@codeaurora.org (David Brown)
Date: Fri, 24 Feb 2012 17:10:00 -0800
Subject: [PATCH] msm: timer: Support sched_clock()
In-Reply-To: <4F47CAF5.4000709@arm.com>
References: <1329874777-12758-1-git-send-email-sboyd@codeaurora.org>
 <20120222215533.GA31480@codeaurora.org> <4F476242.2020909@arm.com>
 <20120224170901.GA9312@codeaurora.org> <4F47C7C5.4090806@arm.com>
 <4F47C9AA.5060806@codeaurora.org> <4F47CAF5.4000709@arm.com>
Message-ID: <20120225011000.GA4611@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 05:37:57PM +0000, Marc Zyngier wrote:
> > This patch relies on the fact that the HAVE_SCHED_CLOCK config option no
> > longer exists. We could push it in if the patch had that option added to
> > the Kconfig, but then it would conflict with the removal of the Kconfig
> > by 6905a65 (ARM: Make the sched_clock framework mandatory, 2012-01-18).
> 
> Ah! Indeed, you're perfectly right.
> 
> > So I guess we send it through the arm-soc tree?
> 
> I don't think arm-soc tracks rmk/for-next, so this has to go via
> Russell's tree. I'll take the patch and send Russell another pull
> request then.

Thanks, Marc.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

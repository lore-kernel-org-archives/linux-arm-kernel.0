From: scaudle@codeaurora.org (Stephen Caudle)
Date: Thu, 16 Dec 2010 10:08:28 -0500
Subject: [PATCH v2] [ARM] gic: Unmask private interrupts on all cores
	during IRQ enable
In-Reply-To: <20101216150357.GT9937@n2100.arm.linux.org.uk>
References: <1288820762-16077-1-git-send-email-scaudle@codeaurora.org>
	<20101130180718.GB8521@n2100.arm.linux.org.uk>
	<4CF6797A.2010807@codeaurora.org>
	<20101201171425.GA29347@n2100.arm.linux.org.uk>
	<4D0102B3.8010302@codeaurora.org> <4D0A281F.1090705@codeaurora.org>
	<20101216150357.GT9937@n2100.arm.linux.org.uk>
Message-ID: <4D0A2B6C.1000400@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2010 10:03 AM, Russell King - ARM Linux wrote:
> I've not changed my thoughts on this.  PPIs should not be handled by
> genirq - it just doesn't make sense for them to be.

Understood.  I will work on a patch to perf events to support the MSM
performance monitor PPI on SMP.

~Stephen

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

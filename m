From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 02 Jan 2013 16:41:00 -0800
Subject: Fw: [PATCH 01/01] arm: fix a preempt_count() corruption for
 CONFIG_PREEMPT=n
In-Reply-To: <20121219000139.GV14363@n2100.arm.linux.org.uk>
References: <20121215085129.71d203b2.pkluba@dension.com>
 <50D10224.30600@codeaurora.org>
 <20121219000139.GV14363@n2100.arm.linux.org.uk>
Message-ID: <50E4D39C.1030001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/12 16:01, Russell King - ARM Linux wrote:
> On Tue, Dec 18, 2012 at 03:54:12PM -0800, Stephen Boyd wrote:
>> Can you try this patch? I'll probably send a follow up patch that
>> consolidates the duplicated preempt_decrement code into some assembly
>> macro. We may also want to fix it up so that assembly stubs call into
>> the preempt tracer. I'm not sure how that works right now with VFP.
> This looks like a sensible fix to me - once tested of course.

Kluba, did the patch work for you?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

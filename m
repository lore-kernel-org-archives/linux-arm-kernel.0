From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Sep 2016 14:07:25 +0100
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <20160912125948.GB13899@leverpostej>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
 <20160912113615.GA20804@leverpostej> <20160912114406.GG23211@arm.com>
 <20160912123027.GA13741@leverpostej> <20160912125948.GB13899@leverpostej>
Message-ID: <57D6A88D.7000002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 13:59, Mark Rutland wrote:
> On Mon, Sep 12, 2016 at 01:30:28PM +0100, Mark Rutland wrote:
>> On Mon, Sep 12, 2016 at 12:44:07PM +0100, Will Deacon wrote:
>>> On Mon, Sep 12, 2016 at 12:36:15PM +0100, Mark Rutland wrote:
>>>> The changes in arm64's <asm/arch_timer.h> are going to conflict with
>>>> some cleanup [1,2] that just landed in the arm64 for-next/core branch.
>>>>
>>>> Could you please rebase atop of that?
>>>
>>> Well, we should figure out what tree this is going through first. There
>>> are a mixture of arm, arm64, driver and dts changes here and not all
>>> of it is carrying the appropriate acks for me to queue it.
>>
>> Given that mix, I had assumed that this would all go through the arm64
>> tree -- I see that Rob has already acked the binding, and I'm happy to
>> give my ack for the driver once that's in shape.
> 
> Now I see that I'd missed the arch/arm changes in patch 4, which lack a
> relevant ack.
> 
> Given that, I don't know what to suggest.

I wouldn't mind delaying patch 4 until it gets acked by RMK, as it
doesn't impact the functionality.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

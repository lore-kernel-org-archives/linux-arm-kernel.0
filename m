From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Sep 2012 10:33:21 -0700
Subject: ARM: smp: why don't eliminate warning "Unknown IPI message 0x1"?
In-Reply-To: <20120918093853.GW12245@n2100.arm.linux.org.uk>
References: <CAKvkGKfjShpdTagsHAhyMr3rHfUQc4qpZjW9wMdht4N36Pk5rA@mail.gmail.com>
 <20120918093853.GW12245@n2100.arm.linux.org.uk>
Message-ID: <5058B061.5020902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/12 02:38, Russell King - ARM Linux wrote:
> On Tue, Sep 18, 2012 at 04:07:49PM +0800, ??? wrote:
>> Russell King want people to move to SGI0 for this, so that we can have SGI1-N
>> as the proper IPIs, but now we can't do this, maybe we must wait for
>> so many years.
>> But, Do you think we can use a another way to resolve this problem,
>> because this warning message will oftenly appeare in products.
>>
>> We can't assume the fixed IPI number that can wakeup secondary cores.
>> "I'd much rather see platforms deciding whether they need to use SGI1
>> or whether they can switch to SGI0 instead."
> Why not just fix your platform to use SGI0.  I think we're _finally_
> there with everyone using SGI0, which means we can commit the patch
> which fixes this.
>

Yes. I'm going to put it in the patch tracker now.

https://patchwork.kernel.org/patch/1433931/

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

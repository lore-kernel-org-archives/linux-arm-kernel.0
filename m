From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 03 Sep 2013 13:51:40 +0100
Subject: [PULL REQUEST] big-endian updates for ARM
In-Reply-To: <20130903134546.5240306b@skate>
References: <20130903101332.GA26613@localhost.localdomain>
 <5225C714.3090504@codethink.co.uk> <20130903134546.5240306b@skate>
Message-ID: <5225DB5C.1070903@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/13 12:45, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Tue, 03 Sep 2013 12:25:08 +0100, Ben Dooks wrote:
>
>> Sorry, I thought that had been fixed, thanks for reminding me.
>>
>> I have fixed it and now on:
>>
>> 	git://git.baserock.org/delta/linux baserock/311-rc7/be/core-v4
>
> Can you resend a proper pull request for this core-v4 branch? There has
> been two fixes since the v3, the Acked-by from one of the mach-mvebu
> maintainers, and my Tested-by.

that was just a confirmation for Dave to test. I will sort out a new
pull request later.

> Also, as indicated on IRC, I confirm that this patch set also works on
> Armada 370. It doesn't work on one particular Armada 370 board that I
> have, but it's using an old bootloader that may be the cause of the
> issue. The BE kernel works fine on the two other Armada 370 boards I've
> tested.
>
> Thanks!
>
> Thomas


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

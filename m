From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 22 Aug 2011 16:50:18 +0200
Subject: [PATCH 3.2 0/4] ARM: simpad: Add support for GPIO
	attached	hardware
In-Reply-To: <20110818102526.GB21865@n2100.arm.linux.org.uk>
References: <1312793379-6020-1-git-send-email-jochen@scram.de>
	<4E43F44A.1000509@scram.de>
	<CAK5ve-J7ARjDDm2OzrBiBBd9VrMjdDdihiRcPFwK4xm+_gwMrg@mail.gmail.com>
	<20110818102526.GB21865@n2100.arm.linux.org.uk>
Message-ID: <4E526CAA.7070108@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.08.2011 12:25, Russell King - ARM Linux wrote:
> On Thu, Aug 18, 2011 at 05:05:49PM +0800, Bryan Wu wrote:
>> On Thu, Aug 11, 2011 at 11:24 PM, Jochen Friedrich<jochen@scram.de>  wrote:
>>> On 08.08.2011 10:49, Jochen Friedrich wrote:
>>>
>>>> This series enables GPIO API on UCB1x00 and implements the GPIO
>>>> API on the CS3 latch. The third patch finally registers platform
>>>> devices for the GPIO attached LED, buttons and I2C bus.
>>>>
>>>> ARM: simpad: Add ucb1x00 GPIO definitions and register GPIO
>>>> ARM: simpad: Cleanup CS3 accessors and add GPIO API
>>>> ARM: simpad: add GPIO based device definitions
>>>> ARM: simpad: replace ARM specific LED code
>>>
>>> ping.
>>>
>>> Did someone have time to look at this yet?
>>>
>> Russell,
>>
>> Is there any comment, or Jochen can just submit them into patch system
>
> I don't think so, and yes.

Done. 7027/1, 7024/1, 7025/1 and 7026/1.

Thanks,
Jochen

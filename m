From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Mon, 22 Aug 2011 15:04:01 +0200
Subject: 46dcfc8 (ARM: Update mach-types) removes used machine types
In-Reply-To: <20110822125653.GB2287@n2100.arm.linux.org.uk>
References: <20110822081000.GA16557@pengutronix.de>
	<201108221318.25140.marek.vasut@gmail.com>
	<20110822124930.GA2287@n2100.arm.linux.org.uk>
	<201108221454.55723.marek.vasut@gmail.com>
	<20110822125653.GB2287@n2100.arm.linux.org.uk>
Message-ID: <4E5253C1.8090702@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Le 22/08/2011 14:56, Russell King - ARM Linux a ?crit :
> On Mon, Aug 22, 2011 at 02:54:55PM +0200, Marek Vasut wrote:
>> On Monday, August 22, 2011 02:49:30 PM Russell King - ARM Linux wrote:
>>> On Mon, Aug 22, 2011 at 01:18:25PM +0200, Marek Vasut wrote:
>>>> On Monday, August 22, 2011 10:33:29 AM Uwe Kleine-K?nig wrote:
>>>>> On Mon, Aug 22, 2011 at 09:17:49AM +0100, Russell King - ARM Linux wrote:
>>>>>> On Mon, Aug 22, 2011 at 10:10:00AM +0200, Uwe Kleine-K?nig wrote:
>>>>>>> Hello Russell,
>>>>>>>
>>>>>>> your commit 46dcfc8 that is in today's next among other changes
>>>>>>> does:
>>>>>>>
>>>>>>> -eukrea_cpuimx25sd      MACH_EUKREA_CPUIMX25    EUKREA_CPUIMX25
>>>>>>> 2820 -eukrea_cpuimx35sd      MACH_EUKREA_CPUIMX35
>>>>>>> EUKREA_CPUIMX35 2821
>>>>>>>
>>>>>>> These two are both marked as "mainlined" on
>>>>>>> http://www.arm.linux.org.uk/developer/machines/ and both are
>>>>>>> actually used
>>>>>>> (arch/arm/mach-imx/mach-{eukrea_cpuimx25,cpuimx35.c})
>>>>>>>
>>>>>>> Can you please add them back? Maybe it's worth to double-check the
>>>>>>> other deletions?!
>>>>>>
>>>>>> No.  They're removed because they're broken (look at them) - I've
>>>>>> added additional checks so I don't have to waste _significant_ time
>>>>>> fixing the entries time and time again.
>>>>>>
>>>>>> The requirement is that the machine_is_xxx() must match the MACH_xxx
>>>>>> parts.  If they don't, they will not exist in future updates.
>>>>>
>>>>> Ah, I wasn't aware of that requirement.
>>>>>
>>>>> Eric, these machine types are owned by you. Do you care to follow up?
>>>>
>>>> Hi Russell,
>>>>
>>>> maybe it'd be worth at least pinging the people before you kill off the
>>>> machine so they can come up with fix?
>>>
>>> I've no idea which get killed off, sorry.
>>
>> This EUKREA thing from what I understood was removed from the machine database
>> and broke things.
>
> So?  The entry was broken.  The entry was changed after submission.  There
> was no communication with me to fix things up.  Therefore I _do_ _not_
> _care_ about it.
>
I did this mistake quite a long time ago just after submission.
I'll come back to you to fix this in a short time, sorry for the annoyance.

Thanks,
Eric

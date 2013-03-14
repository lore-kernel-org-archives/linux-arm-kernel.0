From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Mar 2013 16:16:06 +0530
Subject: [PATCH] ARM: smp: Allow real broadcast device selection instead
 of always dummy
In-Reply-To: <20130314102807.GG13483@e106331-lin.cambridge.arm.com>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com>
 <514046B6.9020005@ti.com>
 <20130313101641.GA13483@e106331-lin.cambridge.arm.com>
 <514061D1.20603@ti.com>
 <20130313122550.GD13483@e106331-lin.cambridge.arm.com>
 <51409EC3.5050905@ti.com>
 <20130313161811.GF13483@e106331-lin.cambridge.arm.com>
 <5141800A.2000307@ti.com>
 <20130314102807.GG13483@e106331-lin.cambridge.arm.com>
Message-ID: <5141AA6E.3020805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 March 2013 03:58 PM, Mark Rutland wrote:
> On Thu, Mar 14, 2013 at 07:45:14AM +0000, Santosh Shilimkar wrote:
>> On Wednesday 13 March 2013 09:48 PM, Mark Rutland wrote:
>>> On Wed, Mar 13, 2013 at 03:44:03PM +0000, Santosh Shilimkar wrote:
>>>> On Wednesday 13 March 2013 05:55 PM, Mark Rutland wrote:
>>>>> On Wed, Mar 13, 2013 at 11:24:01AM +0000, Santosh Shilimkar wrote:
>>>>>> On Wednesday 13 March 2013 03:46 PM, Mark Rutland wrote:
>>>>>>> Hi Santosh,
>>>>
>>>> [..]
>>>>
>>>>>>>
>>>>>>> Is the problem that the dummy timer is being registered as the broadcast
>>>>>>> source, or that it is selected as a local timer in preference of real timers?
>>>>>>>
>>>>>> Dummy timer is preferred over real broadcast timer.
>>>>>
>>>>> Ok.
>>>
>>> [...]
>>>
>>>>> I do agree it'd be worth lowering the dummy timer's rating to ensure it doesn't
>>>>> override a real timer elsewhere. 
>>>>>
>>>> Yep. Can I add you acked-by tag then for $subject patch ?
>>>> Would be good to get this one merged as well.
>>>
>>> Sure. Though could you reword the commit message? The patch solves the more
>>> general issue of a dummy being preferred over real hardware even outside of
>>> choosing the broadcast device.
>>>
>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Thanks. For record, patch is in end of the email which I plan
>> to put into patch system.
>>
>> Regards,
>> Santosh
> 
> The below patch seems fine. Are you intending for this to go in as a fix for
> 3.9-rc*, or as a cleanup for 3.10?
> 
Fix for 3.9-rc*. I have put already it in patch system.

Regards,
Santosh

From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 3 Aug 2012 14:39:32 +0530
Subject: [alsa-devel] DT support for Davinci ASoC platform
In-Reply-To: <501AE3C6.8040708@gmail.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
 <4FF5733E.6000604@gmail.com> <501AE3C6.8040708@gmail.com>
Message-ID: <501B954C.3070606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 8/3/2012 2:02 AM, Daniel Mack wrote:
> On 05.07.2012 12:58, Daniel Mack wrote:
>> Hi Gururaja,
>>
>> On 04.07.2012 14:48, Hebbar, Gururaja wrote:
>>> All,
>>>
>>> Are there any plans or work going on for providing Device Tree Support for Davinci
>>> ASoC?
>>>
>>> I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
>>> task.
>>
>> That's good to know. But isn't there a dependency on the EDMA engine? Is
>> that part ported yet?
> 
> May I ask whether you made any progress on that yet?

Matt Porter from TI is working on DMA engine migration. This would still
be some time away since there is a bunch of work involved here.

To make progress on Audio DT conversion Gururaja is doing an up port of
AM335x EDMA support from TI release to mainline kernel. If you are
interested in it, he can probably share that with you once he posts his
DT patches.

Thanks,
Sekhar

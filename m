From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 18 Apr 2018 10:15:35 -0700
Subject: [RESEND PATCH v2 0/4] ARM: davinci: remove the mach-specific
 aemif driver - part 1
In-Reply-To: <4aa845a4-a96f-c574-19a2-3dd5521fa5bd@ti.com>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <2a2ac117-900c-77b6-f247-49777493e55f@ti.com>
 <CAMpxmJUBFEF7FDp910HwsrNhGhwJDrgRR_9qL0DE5W1M=39MgQ@mail.gmail.com>
 <e3fc3019-888c-cbc3-5e1b-e24c30bc4d49@oracle.com>
 <4aa845a4-a96f-c574-19a2-3dd5521fa5bd@ti.com>
Message-ID: <58ae9d30-9fb0-d12f-4cc6-ed985c63e480@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/18/2018 1:17 AM, Sekhar Nori wrote:
> On Tuesday 17 April 2018 10:59 PM, Santosh Shilimkar wrote:
>> On 4/17/2018 5:36 AM, Bartosz Golaszewski wrote:
>>> 2018-04-17 12:53 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>>>> Hi Bartosz,
>>
>> [...]
>>
>>>>> This series applies on top of v8 of David Lechner's CCF series.
>>>>
>>>> Are there any patches in the series that can safely be applied to
>>>> v4.17-rc1?
>>
>>>
>>> Hi Sekhar,
>>>
>>> yes, all of them. They're not linked to David's work in any way.
>>>
>> Please separate the driver/emif/* patches from the series. These
>> are not fixes so they are not rcx candidates. But will queue them
>> up for next merge window. Thanks !!
> 
> Thanks Santosh! Can you please queue the drivers/emif/ patches on an
> immutable branch based off v4.17-rc1 which I can then merge to queue the
> platform patches?
> 
Sure. Will send a note once I get to it.

Regards,
Santosh

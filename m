From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 15 Apr 2016 15:39:42 +0530
Subject: [PATCH 0/2] da8xx clocks (was part of "da8xx USB clocks")
In-Reply-To: <57108BFA.4080509@ti.com>
References: <1460661217-7389-1-git-send-email-david@lechnology.com>
 <570FEEDB.7000109@lechnology.com> <57108BFA.4080509@ti.com>
Message-ID: <5710BDE6.6000901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 12:06 PM, Sekhar Nori wrote:
> On Friday 15 April 2016 12:56 AM, David Lechner wrote:
>> On 04/14/2016 02:13 PM, David Lechner wrote:
>>> I have separated these patches from the "da8xx USB clocks" series
>>> since that
>>> series no longer depends on the clock init being moved.
>>>
>>> Tested working on the linux-davinci/master branch with LEGO MINDSTORMS
>>> EV3.
>>>
>>> David Lechner (2):
>>>    ARM: davinci: Move clock init after ioremap.
>>>    ARM: davinci: da850: use clk->set_parent for async3
>>>
>>>   arch/arm/mach-davinci/clock.c  |  2 +-
>>>   arch/arm/mach-davinci/common.c |  6 ---
>>>   arch/arm/mach-davinci/da830.c  |  2 +
>>>   arch/arm/mach-davinci/da850.c  | 90
>>> ++++++++++++++++++++----------------------
>>>   arch/arm/mach-davinci/dm355.c  |  1 +
>>>   arch/arm/mach-davinci/dm365.c  |  1 +
>>>   arch/arm/mach-davinci/dm644x.c |  1 +
>>>   arch/arm/mach-davinci/dm646x.c |  1 +
>>>   8 files changed, 49 insertions(+), 55 deletions(-)
>>>
>>
>> Hmm... I was just reviewing my previous emails and you said that you
>> have already applied these two patches, but they don't seem to have made
>> it into the linux-davinci/master branch with the others.
> 
> No, I had commented about removing the new clk init function you had
> introduced so I was waiting for that to be addressed. I was okay with
> the second patch in this series, but did not push it to master branch as
> it depends on clk init movement and breaks boot if applied independently.
> 
> I will review these two patches.

Looks good to me. I will wait couple more days before applying for any
more review.

Regards,
Sekhar

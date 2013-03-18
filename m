From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 18 Mar 2013 11:14:15 +0100
Subject: [PATCH V2 0/8] ARM: dts: Various OMAP2+ device-tree updates
In-Reply-To: <CABYxbz5cW0Jt12SGcMpN5L0n18C6Mis0gRoBgSHWnxuAz6chGA@mail.gmail.com>
References: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
 <51433094.1000104@ti.com>
 <CABYxbz5cW0Jt12SGcMpN5L0n18C6Mis0gRoBgSHWnxuAz6chGA@mail.gmail.com>
Message-ID: <5146E8F7.8080008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anil,

On 03/17/2013 10:35 AM, Anil Kumar wrote:
> Hi Benoit,
> 
> On Fri, Mar 15, 2013 at 8:00 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Hi Jon,
>>
>> On 03/15/2013 02:57 PM, Jon Hunter wrote:
>>> Various OMAP device-tree updates for PMU, DMA, GPIO, GPMC and boards.
>>>
>>> The DMA, PMU and OMAP3430 SDP board changes have been sent before
>>> individually but re-sending here as a complete series for v3.10.
>>>
>>> This is based upon Benoit's for_3.10/dts branch [1]. Branch available
>>> here [2].
>>>
>>> V2 changes:
>>> - Rebased on Benoit's for_3.10/dts branch
>>> - Squashed patches adding support for OMAP3430 SDP board and patch
>>>   to add flash support for OMAP3430 SDP board.
>>>
>>> [1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.10/dts
>>> [2] git://github.com/jonhunter/linux.git omap-dt-for-v3.10
>>
>> Thanks for the repost. I've just applied your branch in my for_3.10/dts
>> branch.
> 
> I think you missed below patch which is needed for gpmc nand to work fine.
> Without this patch nand will not work on OMAP3430 SDP board.
> 
> Jon Hunter:-
>   ARM: OMAP2+: Fix-up gpmc merge error

Well, that patch is not part of Jon's series and it looks like it was
posted for 3.9-rc3.
BTW, Paul W is just reporting a regression about that patch.

Anyway, I'll rebase on top of -rc3 to get the latest fixes.

Regards,
Benoit

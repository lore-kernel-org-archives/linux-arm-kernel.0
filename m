From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 21 Dec 2012 09:31:16 +0530
Subject: [PATCH 0/8] Flip on multiplatform support for omap2plus for v3.9
In-Reply-To: <CALF0-+XspOix_RiNkWN7d1L9uxBZi7Zf5SDaKcx0P7P_Z3anqA@mail.gmail.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
 <20121220155518.GX4989@atomide.com>
 <CALF0-+XspOix_RiNkWN7d1L9uxBZi7Zf5SDaKcx0P7P_Z3anqA@mail.gmail.com>
Message-ID: <50D3DF0C.1050606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Garcia,

On Friday 21 December 2012 05:41 AM, Ezequiel Garcia wrote:
> Hello Tony,
>
> On Thu, Dec 20, 2012 at 12:55 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Tony Lindgren <tony@atomide.com> [121219 11:28]:
>>> Hi all,
>>>
>>> These patches enable multiplatform support for omap2plus.
>>>
>>> To build and boot it against the current mainline kernel
>>> you need the following:
>>>
>>> [PATCH 1/2] ARM: l2x0: Only set .set_debug on PL310 r3p0 and earlier
>>> [PATCH 2/2] ARM: disable errata work-arounds which access secure registers
>>> [GIT PULL 1/2] omap fixes for v3.8 merge window
>>> [GIT PULL 2/2] omap cleanup for v3.8 merge window
>>> [GIT PULL] two trivial omap build error fixes for v3.8 merge window
>>> cpts: Fix build error caused by include of plat/clock.h
>>
>
> I'm trying this on my IGEP v2 board (using Javier's patches for DT).
>
> I've applied these series on top of your branch
> "omap-for-v3.8/fixes-for-merge-window-part2".
>
> However, I'm finding some conflicts (fb.c appears in plat-omap,
> some missing headers, etc.)
>
> Could you suggest a better branch to base the series?
Can you try it on current mainline.
It applies without any conflicts..

Thanks
Lokesh
>
> Thanks!
>
>      Ezequiel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

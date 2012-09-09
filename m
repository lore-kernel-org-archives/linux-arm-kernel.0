From: gerg@snapgear.com (Greg Ungerer)
Date: Sun, 9 Sep 2012 14:40:25 +1000
Subject: [PATCH] ARM: ks8695: add board support for the OpenGear boards
 based on the KS8695
In-Reply-To: <CAOesGMiixufaORkZcabnYRyCWHcG6KT4Q0if3+-PZrUUpprCNg@mail.gmail.com>
References: <1346996139-5692-1-git-send-email-gerg@snapgear.com>
 <201209071221.56938.arnd@arndb.de>
 <CAOesGMiixufaORkZcabnYRyCWHcG6KT4Q0if3+-PZrUUpprCNg@mail.gmail.com>
Message-ID: <504C1DB9.2020305@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 09/08/2012 01:20 PM, Olof Johansson wrote:
> On Fri, Sep 7, 2012 at 5:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 07 September 2012, gerg at snapgear.com wrote:
>>> From: Greg Ungerer <gerg@uclinux.org>
>>>
>>> A number of boards produced by OpenGear and based on the Micrel KS8695 SoC.
>>> Add board support to the KS8695 kernel code to support them.
>>>
>>> The following machine type entries will need to be added back into the
>>> mach-types file with these in mainline:
>>>
>>>      cm4008      MACH_CM4008       CM4008       624
>>>      cm41xx      MACH_CM41XX       CM41XX       672
>>>      cm4002      MACH_CM4002       CM4002       876
>>>      im42xx      MACH_IM42XX       IM42XX       1105
>>>      im4004      MACH_IM4004       IM4004       1400
>>>
>>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>
> Both patches applied to a ks8695/boards branch, part of next/boards in arm-soc.
>
> Greg, you should submit separate patch to add the machine types to
> Russell's patch tracker.

Yep, I'll create some patches for those.


> We are of course looking forward to efforts
> to move these platforms to device tree, since we want to avoid adding
> non-dt boards from here on out.

Yes that would be nice. I am not sure when I will have some time
to take that on. But hopefully sometime soon.

Regards
Greg



-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com

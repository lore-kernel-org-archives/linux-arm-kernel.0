From: gerg@snapgear.com (Greg Ungerer)
Date: Thu, 13 Sep 2012 16:40:57 +1000
Subject: [PATCH] ARM: ks8695: add board support for the OpenGear boards
 based on the KS8695
In-Reply-To: <CAOesGMiixufaORkZcabnYRyCWHcG6KT4Q0if3+-PZrUUpprCNg@mail.gmail.com>
References: <1346996139-5692-1-git-send-email-gerg@snapgear.com>
 <201209071221.56938.arnd@arndb.de>
 <CAOesGMiixufaORkZcabnYRyCWHcG6KT4Q0if3+-PZrUUpprCNg@mail.gmail.com>
Message-ID: <50517FF9.9040801@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 08/09/12 13:20, Olof Johansson wrote:
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

I am looking for some guidance here. Russell nacked a separate patch
that put the board ID's back in. Do you want to drop these patches
and I roll new ones that include the mach-types update as well?
Or perhaps do this all some other way?

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com

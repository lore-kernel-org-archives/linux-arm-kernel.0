From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 9 Sep 2016 09:37:20 -0700
Subject: [PATCH 4/8] ARM: dts: bcm283x: Add a new EMMC pin group from the
 downstream tree.
In-Reply-To: <e61a4efa-3685-6694-5fda-3272f6605665@i2se.com>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
 <1473244289-20728-5-git-send-email-kraxel@redhat.com>
 <87650770.23554.026b1e4b-e35d-48e6-9394-7eeea0ff9add.open-xchange@email.1und1.de>
 <1473320687.6698.25.camel@redhat.com>
 <373fe61a-61d4-164e-0760-d68a0c4925dd@broadcom.com>
 <e61a4efa-3685-6694-5fda-3272f6605665@i2se.com>
Message-ID: <5d464384-ba0d-516f-9fde-3a65386d4834@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 16-09-08 11:58 PM, Stefan Wahren wrote:
> Hi Scott,
>
> Am 08.09.2016 um 21:50 schrieb Scott Branden:
>> Hi Gerd/Eric
>>
>> On 16-09-08 12:44 AM, Gerd Hoffmann wrote:
>>> On Mi, 2016-09-07 at 20:13 +0200, Stefan Wahren wrote:
>>>>> Gerd Hoffmann <kraxel@redhat.com> hat am 7. September 2016 um 12:31
>>>>> geschrieben:
>>>>>
>>>>>
>>>>> From: Eric Anholt <eric@anholt.net>
>>>>>
>>>>> This will be used for having EMMC (sdhci-bcm2835.c) drive the
>>>>> wireless.
>>>>
>>>> sdhci-bcm2835.c has been replaced by sdhci-iproc.c
>>>
>>> Ah, right, I'll update the commit msg for v2.
>>>
>> Should we entirely remove sdhci-bcm2835.c to reduce confusion going
>> forward?
>
> did i missed something?
No - looks like I did.  Everything is cleaned up in latest.
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=46cd175c9788e39a1c57698ab58f34844d216428
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=7eb16493ecaa41ceeb448717ee2c59690cd9047f
>
>
>>
>>>> How about adding pull defines to include/dt-bindings/pinctrl/bcm2835.h?
>>>
>>> Already there (or do you mean something other than '#define
>>> BCM2835_FSEL_*' ?)
>>>
>>> cheers,
>>>   Gerd
>>>
>>
>> Thanks,
>>  Scott
>

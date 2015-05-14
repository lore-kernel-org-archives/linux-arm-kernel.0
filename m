From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 14 May 2015 14:28:12 -0400
Subject: [PATCH 0/4] ARM: keystone: Enable Netcp driver on K2 EVMs
In-Reply-To: <20150511160026.GH2067@n2100.arm.linux.org.uk>
References: <1429817852-27938-1-git-send-email-m-karicheri2@ti.com>
 <55395981.8050902@oracle.com> <553A5E12.9040202@ti.com>
 <553A630F.4060008@oracle.com> <5550D0FD.7060903@ti.com>
 <20150511160026.GH2067@n2100.arm.linux.org.uk>
Message-ID: <5554E93C.1080102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2015 12:00 PM, Russell King - ARM Linux wrote:
> On Mon, May 11, 2015 at 11:55:41AM -0400, Murali Karicheri wrote:
>> On 04/24/2015 11:36 AM, santosh shilimkar wrote:
>>> On 4/24/2015 8:15 AM, Murali Karicheri wrote:
>>>> On 04/23/2015 04:43 PM, santosh shilimkar wrote:
>>>>> On 4/23/2015 12:37 PM, Murali Karicheri wrote:
>>>>>> NetCP driver support patches are already merged to v4.0.nd v4.1.
>>>>>> This series introduce patches to update the DTS bindings and
>>>>>> defconfig so that the network driver is fully functional on K2
>>>>>> EVMs :- K2HK, K2L and K2E.
>>>>>>
>>>>> Nice and Thanks Murali for sending these up.
>>>>>
>>>>>> It will be great if this can be merged to v4.1.
>>>>>>
>>>>> Its too late for the 4.1 now. For the same reason, we also
>>>>> couldn't get the MMU switching fixes in this merge window.
>>>>
>>>> For my reference, can you point me to the MMU switching fixes you are
>>>> referring to?
>>>>
>>> http://www.spinics.net/lists/arm-kernel/msg411178.html
>>>
>>> Regards,
>>> Santosh
>> Santosh,
>>
>> Is MMU switching series applied to a sub system branch already that I can
>> pull to do some testing on K2 devices?
>
> Shall I send you the patches directly?
>
Russell,

Could you send me the patch set? I haven't seen anything in my inbox 
from you. So just want to check. If you have it on a branch, please 
provide the details, I can pull and test.

Regards,
-- 
Murali Karicheri
Linux Kernel, Keystone

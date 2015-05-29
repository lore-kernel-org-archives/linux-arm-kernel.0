From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 29 May 2015 16:21:15 -0400
Subject: [PATCH 0/4] ARM: keystone: Enable Netcp driver on K2 EVMs
In-Reply-To: <20150511160026.GH2067@n2100.arm.linux.org.uk>
References: <1429817852-27938-1-git-send-email-m-karicheri2@ti.com>
 <55395981.8050902@oracle.com> <553A5E12.9040202@ti.com>
 <553A630F.4060008@oracle.com> <5550D0FD.7060903@ti.com>
 <20150511160026.GH2067@n2100.arm.linux.org.uk>
Message-ID: <5568CA3B.4000709@ti.com>
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

As promised I have taken sometime today to test this series that you 
have sent to me privately and all of my below tests passed.
1. Boot and reboot test on all EVMs (K2HK, K2E and K2L)
2. Apply network patches (lined up for v4.2 merge) and do boot with nfs 
file system. Also performed iperf network traffic tests.
3. Bring up SATA harddisk on K2E EVM and do file copy tests.

Based on this, please add my Tested-by to this series.

Tested-by: Murali Karicheri <m-karicheri2@ti.com>
Regards,
-- 
Murali Karicheri
Linux Kernel, Keystone

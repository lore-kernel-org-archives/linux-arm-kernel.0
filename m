From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 24 Apr 2015 08:36:47 -0700
Subject: [PATCH 0/4] ARM: keystone: Enable Netcp driver on K2 EVMs
In-Reply-To: <553A5E12.9040202@ti.com>
References: <1429817852-27938-1-git-send-email-m-karicheri2@ti.com>
 <55395981.8050902@oracle.com> <553A5E12.9040202@ti.com>
Message-ID: <553A630F.4060008@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2015 8:15 AM, Murali Karicheri wrote:
> On 04/23/2015 04:43 PM, santosh shilimkar wrote:
>> On 4/23/2015 12:37 PM, Murali Karicheri wrote:
>>> NetCP driver support patches are already merged to v4.0.nd v4.1.
>>> This series introduce patches to update the DTS bindings and
>>> defconfig so that the network driver is fully functional on K2
>>> EVMs :- K2HK, K2L and K2E.
>>>
>> Nice and Thanks Murali for sending these up.
>>
>>> It will be great if this can be merged to v4.1.
>>>
>> Its too late for the 4.1 now. For the same reason, we also
>> couldn't get the MMU switching fixes in this merge window.
>
> For my reference, can you point me to the MMU switching fixes you are
> referring to?
>
http://www.spinics.net/lists/arm-kernel/msg411178.html

Regards,
Santosh

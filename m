From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 16 Sep 2015 13:01:18 -0400
Subject: [PATCH v1 1/2] soc: ti: display firmware file name as part of
 boot log
In-Reply-To: <55F88B81.2000308@oracle.com>
References: <1441403199-10936-1-git-send-email-m-karicheri2@ti.com>
 <55EA673F.8010904@oracle.com> <55F06075.6050405@ti.com>
 <55F8600D.2070701@ti.com> <55F88B81.2000308@oracle.com>
Message-ID: <55F9A05E.4090000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2015 05:20 PM, santosh shilimkar wrote:
> On 9/15/2015 11:14 AM, Murali Karicheri wrote:
>> On 09/09/2015 12:38 PM, Murali Karicheri wrote:
>>> On 09/04/2015 11:53 PM, santosh.shilimkar at oracle.com wrote:
>>>> On 9/4/15 5:46 PM, Murali Karicheri wrote:
>>>>> To help the user, print the PDSP file name as part of
>>>>> knav_queue_load_pdsp(). This will be useful for users to know what
>>>>> version of the firmware is loaded to PDSP. Also update the
>>>>> document for the location of the QMSS accumulator PDSP firmware.
>>>>>
>>>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>>>> ---
>>>>
>>>> Looks fine. Will pick both the patches.
>>>>
>>>
>>> Thanks Santhosh.
>>>
>>> Is there a requirement to add the firmware to linux-firmware.git. Right
>>> now I have provided link to ti git repo that has the firmware. I have
>>> the patch ready in case this is required. Do you know?
>>>
>>> Murali
>>>> Regards,
>>>> Santosh
>>>>
>>>>
>>>
>>>
>> Santosh,
>>
>> I have checked v4.3-rc1 and I don't see it. Did you send the pull
>> request?
>>
> They are in the queue fo 4.4-rc1. They were too late for 4.3.
> You might know already, typically as a rule of thumb followed
> on arm-soc, we need to get patches reviewed/acked by rc4 to make
> it for next merge window.
> Ofcourse genuine bug fixes can make it to the same cycle.
Is there a branch where you have applied the patches that you can 
provide me? I want to send it to internal list for merge.

Murali
>
> Regards,
> Santosh
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone

From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 9 Sep 2015 13:23:23 -0400
Subject: [PATCH v1 1/2] soc: ti: display firmware file name as part of
 boot log
In-Reply-To: <55F06879.3060000@oracle.com>
References: <1441403199-10936-1-git-send-email-m-karicheri2@ti.com>
 <55EA673F.8010904@oracle.com> <55F06075.6050405@ti.com>
 <55F06879.3060000@oracle.com>
Message-ID: <55F06B0B.5020100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2015 01:12 PM, santosh.shilimkar at oracle.com wrote:
> On 9/9/15 9:38 AM, Murali Karicheri wrote:
>> On 09/04/2015 11:53 PM, santosh.shilimkar at oracle.com wrote:
>>> On 9/4/15 5:46 PM, Murali Karicheri wrote:
>>>> To help the user, print the PDSP file name as part of
>>>> knav_queue_load_pdsp(). This will be useful for users to know what
>>>> version of the firmware is loaded to PDSP. Also update the
>>>> document for the location of the QMSS accumulator PDSP firmware.
>>>>
>>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>>> ---
>>>
>>> Looks fine. Will pick both the patches.
>>>
>>
>> Thanks Santhosh.
>>
>> Is there a requirement to add the firmware to linux-firmware.git. Right
>> now I have provided link to ti git repo that has the firmware. I have
>> the patch ready in case this is required. Do you know?
>>
> Standard distro's will look for linux-firmware.git as a source to get
> the firmware files used by kernel so yes, you should add these firmware
> files to that repo.
Ok. Will send a patch for this.

Murali
>
> Regards,
> Santosh
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone

From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Thu, 17 Aug 2017 07:28:49 -0500
Subject: [PATCH v2 1/2] usb: dwc3: keystone: Add PM_RUNTIME Support to
 DWC3 Keystone USB driver
In-Reply-To: <87r2waqu1s.fsf@linux.intel.com>
References: <20170816215408.13076-1-fcooper@ti.com>
 <20170816215408.13076-2-fcooper@ti.com> <87r2waqu1s.fsf@linux.intel.com>
Message-ID: <926be30f-3a97-ab81-876f-610bdd57775d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/17/2017 07:04 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Franklin S Cooper Jr <fcooper@ti.com> writes:
>> For 66AK2Gx there is a requirement to use PM Runtime to properly manage
>> clocks and the power domains. Therefore, add PM runtime support. Remove
>> legacy clock api's calls since other users of this driver worked without
>> these clock apis calls.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
> 
> I already have the previous version of this in my tree. Seems like the
> only difference was on binding document, right? Do I need to change
> anything in my 'next' and/or 'testing/next' branches?

Correct the binding document is the only difference. Both of your
branches looks good.

> 

From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 7 Jun 2013 16:37:32 +0530
Subject: [PATCH 14/14] ARM: OMAP4: hwmod data: Clean up the data file
In-Reply-To: <51B1B936.5030302@ti.com>
References: <1370600827-21679-1-git-send-email-r.sricharan@ti.com>
 <51B1B936.5030302@ti.com>
Message-ID: <51B1BEF4.6080606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Friday 07 June 2013 04:13 PM, Benoit Cousson wrote:
> Hi Sricharan,
>
> On 06/07/2013 12:27 PM, Sricharan R wrote:
>> - The IO resource information like dma request lines, irq number and
>>   ocp address space can be populated via dt blob. So such data is stripped
>>   from OMAP4 SOC hwmod data file.
>>
>> - The devices which are still missing the device tree bindings,
>>   address space entries are not removed yet. When such devices add
>>   the dt bindings, respective address space data can be deleted.
>>
>> - Also other unnessecary hwmods like firewalls are removed as a part of this.
> typo.
 Ok, will correct.

> That part is fine, but you should add that by doing that you have to
> create new direct link from MPU to EMIFs that did no exist before.
 Yes, the mpu->emif link is already added in the patch

>> The above update, results in reduction of about ~1650 lines of code.
>>
>> The comment about autogeneration is removed temporarily. Should be brought
>> back after syncing the scripts.
> You'd better keep it and append a note stating that.
> If you remove it, I fairly know nobody will ever add it again :-)
 Ok, will change this then :-)
> Otherwise the patch looks fine.
>
> Thanks,
> Benoit
Regards,
 Sricharan

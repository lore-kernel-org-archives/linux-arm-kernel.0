From: majun258@huawei.com (majun (F))
Date: Fri, 6 May 2016 09:12:55 +0800
Subject: [PATCH v3 0/2] irqchip/mbigen: fix the IO remap problem in mbigen
 driver.
In-Reply-To: <572B5D97.4090004@arm.com>
References: <1458203641-17172-1-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1603211124450.3978@nanos> <56F0B7C3.8070001@huawei.com>
 <572B5D97.4090004@arm.com>
Message-ID: <572BEF97.5020003@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc:

? 2016/5/5 22:49, Marc Zyngier ??:
> On 22/03/16 03:10, majun (F) wrote:
>>
>>
>> ? 2016/3/21 18:29, Thomas Gleixner ??:
>>> On Thu, 17 Mar 2016, MaJun wrote:
>>>> This patch set is used to fix the problem of remap a set of registers
>>>> repeatedly in current mbigen driver.
>>>>
>>>>   irqchip/mbigen:Change the mbigen node definition in dt binding file
>>>>   irqchip/mbigen:Change the mbigen driver based on the new mbigen node definition
>>>
>>> These subject lines are still horrible as they tell nothing about the nature
>>> of the change. I fixed them up along with the changelogs and applied them to
>>> irq/urgent. Can you spot the difference?
>>
>> Yes, after you changing, the subject and change log clearly show why we need to
>> do this change.
>> I have learned a lot from you :)
>>
>>>
>>> While at it. The config switch for this driver is horrible. It's just in the
>>> middle of the device driver configs. Why is this configurable by the user at
>>> all? It simply should be selected by arm64 or some subarch configuration
>>> there. Please clean that up.
>>>
>> will do.
> 
> So what's the status of this? Do you still plan to respin it?
> 

This patch set had been ACK by Thomas.
If you mean the mbigen driver config switch problem, the patch for this problem also
had been ACK by thomas.
please see the link:
https://lkml.org/lkml/2016/3/23/76

Thanks
Ma Jun

> Thanks,
> 
> 	M.
> 

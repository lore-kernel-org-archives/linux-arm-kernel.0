From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 21 Mar 2018 09:33:03 +0000
Subject: Failed to boot ARM64 boards for recent linux-next
In-Reply-To: <5AB22377.1000404@rock-chips.com>
References: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
 <077cecdd-7982-dd33-454f-e38cc571366c@arm.com>
 <9cff515e-fcb9-a1c0-329b-a18c3bed0071@rock-chips.com>
 <fe56e7e3-50dd-88de-ce61-f3cbcc1f572b@rock-chips.com>
 <5AB0DEB2.4000803@rock-chips.com>
 <e603186e-b9e8-c7d5-b98a-f5bcce94f7d5@arm.com>
 <cbc89d68-ba41-1f6a-4ab2-4c9647b48f75@huawei.com>
 <d18d6f27-7270-d2d7-58b9-3bf16ffe6b0a@arm.com>
 <ff6cd434-2227-12a6-b3b9-325da78a7fa9@huawei.com>
 <2aed10a0-ad3d-d9fc-7b6e-3b6877bff0be@arm.com>
 <13507742-ddb8-0b43-cd09-14a57ec2a07a@rock-chips.com>
 <5AB1F763.3040409@rock-chips.com>
 <680aba8d-4117-227b-d5a1-ad7121d2565f@arm.com>
 <5AB22377.1000404@rock-chips.com>
Message-ID: <de4be2ef-ee2c-60f8-a08e-11e378e55343@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/18 09:18, JeffyChen wrote:
> Hi Marc,
> 
> On 03/21/2018 04:52 PM, Marc Zyngier wrote:
>> Hi Jeffy,
>>
>> On 21/03/18 06:10, JeffyChen wrote:
>>> Hi Shawn,
>>>
>>> On 03/21/2018 08:34 AM, Shawn Lin wrote:
>>>>
>>>> @Jeffy
>>>>
>>>> Could you help test Marc's latest patch on your RK3399 kevin/Gru or
>>>> whatever Chromebook?
>>> tested on my chromebook kevin, it works with that patch.
>>
>> This is very odd. It completely fails on mine, which is aannoying.
>> Do you have any special firmware? Or the stock firmware?
>>
> 
> hmmm, my kevin's firmware is official:
> localhost / # cat /var/log/bios_info.txt
> version              | Google_Kevin.8785.241.0
> ro bios version      | Google_Kevin.8785.241.0

(booting into ChromeOS) Definitely not what I have on mine:
8785.220.0 as the runtime version, and 8785.94.7 as the RO one.

This is a retail machine, bought in November. So what you have cannot be
the stock firmware.

What changes related to the GIC have been applied to this FW?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

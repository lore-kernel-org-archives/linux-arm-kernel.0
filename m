From: dingtianhong@huawei.com (Ding Tianhong)
Date: Mon, 16 Jan 2017 21:04:23 +0800
Subject: [PATCH v7 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161601 erratum
In-Reply-To: <63e1f4de-f5e8-6a19-2f8f-61b198f6369f@arm.com>
References: <1483772858-10380-1-git-send-email-dingtianhong@huawei.com>
 <6c33e4e9-6472-4738-aea2-55dcaab3a94f@huawei.com>
 <ff9c81c2-90ef-a5c2-6f0b-c6cf5d0d11a9@arm.com>
 <06fd3327-f451-bc0d-b80c-4200bc9fadaa@huawei.com>
 <e0aa52a6-8dc7-65d6-6a3a-c753b6c9538e@huawei.com>
 <63e1f4de-f5e8-6a19-2f8f-61b198f6369f@arm.com>
Message-ID: <21e5386a-b7d0-8c8e-3d7c-22b6be9c02f9@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/1/16 19:29, Marc Zyngier wrote:
> On 16/01/17 10:37, Ding Tianhong wrote:
>>
>>
>> On 2017/1/12 21:24, Ding Tianhong wrote:
>>>
>>> On 2017/1/12 17:11, Marc Zyngier wrote:
>>>> On 12/01/17 04:23, Ding Tianhong wrote:
>>>>> Hi Marc:
>>>>>
>>>>> How about this v7, if any suggestions very grateful.
>>>>
>>>> It's been less than 5 days since you posted this. I'll get to it once I
>>>> finish reviewing all the other patches that are sitting in the queue
>>>> right before yours.
>>>>
>>>
>>> Ok and sorry for the noisy.
>>>
>>
>> Hi Marc?
>>
>> After discussion with the chip developer, we decide to update the erratum id for this bug, so I will resend a new version
>> about this, if you has start to review this v7 patch set, I think I could wait until you have finished yet. :)
> 
> This has to be a stable erratum ID, and it won't be changed once the
> workaround is merged (all you'll be able to do is to add new IDs where
> the same fix is applicable). So please post the revised series, and make
> sure that this is the *final* ID update.
> 

Yes?the *final* ID will be the stable ID and could be record in CPU erratum doc which could be get from Hisilicon webpage.
The final format for erratum ID is just like:
<Errata-Prefix><SeriesFlag><ModuleID><SerialNum>
Errata-Prefix=1610, SeriesFlag=1, ModuleID=0x, SerialNum=01.

Thanks
Ding

> Thanks,
> 
> 	M.
> 

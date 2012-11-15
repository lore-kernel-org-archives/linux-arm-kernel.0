From: jason77.wang@gmail.com (Hui Wang)
Date: Thu, 15 Nov 2012 16:56:30 +0800
Subject: [PATCH V3 0/5] SMP support for Armada XP
In-Reply-To: <50A4ACC5.4040209@free-electrons.com>
References: <1352931637-3405-1-git-send-email-gregory.clement@free-electrons.com>
 <50A4ABD1.3070902@gmail.com> <50A4ACC5.4040209@free-electrons.com>
Message-ID: <50A4AE3E.1040307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory CLEMENT wrote:
> Hello Hui,
>
> On 11/15/2012 09:46 AM, Hui Wang wrote:
>   
>> Sorry for asking a question. Does it support CPU HOTPLUG? I am just 
>> testing the marvell 2012_Q4.1, and found the CPU HOTPLUG (echo 0|1 > 
>> /sys/devices/system/cpu/cpu1/online) doesn't work on the XP_GP board, 
>> does your BSP have the same problem?
>>
>>     
>
> Indeed, we don't support it yet, but we plan to add this feature once
> this "basic" support will be included in the 3.8.
>
>   
Got it, thanks.

>> Regards,
>> Hui.
>>
>> Gregory CLEMENT wrote:
>>     
>>> Hello,
>>>
>>> The purpose of this patch set is to add the SMP support for the Armada
>>> XP SoCs. Beside the SMP support itself brought by the last 3 patches,
>>> this patch set also adds the support for the coherency fabric unit and
>>>   
>>>       
>
>
>   

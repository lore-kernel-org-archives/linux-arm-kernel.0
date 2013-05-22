From: guz.fnst@cn.fujitsu.com (Gu Zheng)
Date: Wed, 22 May 2013 09:30:11 +0800
Subject: [PATCH 00/19] driver:usb&net: add missing platform_driver owner
In-Reply-To: <519B418A.7060805@huawei.com>
References: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
 <20130520.232619.964940909999914694.davem@davemloft.net>
 <20130521084108.1a585f32@skate> <519B2993.4090409@cn.fujitsu.com>
 <20130521110616.21eee053@skate> <519B418A.7060805@huawei.com>
Message-ID: <519C1FA3.2020500@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 05:42 PM, Libo Chen wrote:

> On 2013/5/21 17:06, Thomas Petazzoni wrote:
>> Dear Gu Zheng,
>>
>> On Tue, 21 May 2013 16:00:19 +0800, Gu Zheng wrote:
>>
>>>> Or, maybe make the existing module_platform_driver() macro do this?
>>>
>>> But not all the modules use module_platform_driver() macro to replace the module init/exit.
>>
>> Then maybe it's a good opportunity to convert those ones to use
>> module_platform_driver() ?
>>
>> Thomas
>>
> 
>  In my opinion, not all modules can use module_platform_driver() macro to replace the module init/exit easily, like us3mc_init.
> 
>  Furthermore this work will touch various platforms and architectures, I am worried it is hard to *test* (compile and boot).

Agree. I stick to the way that David mentioned.

Thanks,
Gu

> 
>  What do you think?
> 
> 

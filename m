From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 13 Jan 2017 09:30:28 +0000
Subject: [PATCH v2 2/2] arm64: cacheinfo: add support to override cache
 levels via device tree
In-Reply-To: <58789899.3080909@huawei.com>
References: <1484245772-31511-1-git-send-email-sudeep.holla@arm.com>
 <1484245772-31511-2-git-send-email-sudeep.holla@arm.com>
 <58789899.3080909@huawei.com>
Message-ID: <609a80c7-9a85-2786-1e5a-a5c2340900b9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/01/17 09:06, Tan Xiaojun wrote:
> On 2017/1/13 2:29, Sudeep Holla wrote:
>> The cache hierarchy can be identified through Cache Level ID(CLIDR)
>> architected system register. However in some cases it will provide
>> only the number of cache levels that are integrated into the processor
>> itself. In other words, it can't provide any information about the
>> caches that are external and/or transparent.
>>
>> Some platforms require to export the information about all such external
>> caches to the userspace applications via the sysfs interface.
>>
>> This patch adds support to override the cache levels using device tree
>> to take such external non-architected caches into account.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
> 

Thanks for testing.

-- 
Regards,
Sudeep

From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 30 Mar 2017 11:23:54 +0100
Subject: spin_lock behavior with ARM64 big.Little/HMP
In-Reply-To: <537888bcf5dd5ea3c3418fc9e9e3ff79@codeaurora.org>
References: <400ab4b8b2354c5b9283f6ed657363a0@codeaurora.org>
 <8d9d6333-0ebe-65c4-c6f1-3e3475e3e535@arm.com>
 <f9fc9549d801fece7422d97d5d89df8b@codeaurora.org>
 <f17207e7-e58c-2e42-04a8-50ed83a9616f@arm.com>
 <537888bcf5dd5ea3c3418fc9e9e3ff79@codeaurora.org>
Message-ID: <e2566794-5818-c42e-ec1b-aa8ac7bc196f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/03/17 05:12, Vikram Mulukutla wrote:
> 
> Hi Sudeep,
> 
>>
>> Interesting. Just curious if this is r0p0/p1 A53 ? If so, is the errata
>> 819472 enabled ?
> 
> Sorry for bringing this up after the loo-ong delay, but I've been
> assured that the A53 involved is > r0p1. I've also confirmed this
> problem on multiple internal platforms, and I'm pretty sure that it
> occurs on any b.L out there today. Also, we found the same problematic
> lock design used in the workqueue code in the kernel, causing the same
> livelock. It's very very rare and requires a perfect set of circumstances.
> 
> If it would help I can provide a unit test if you folks would be
> generous enough to test it on the latest Juno or something b.L that's
> also upstream.
> 

Sure, please do share the unit test. I will give that a try on Juno.

-- 
Regards,
Sudeep

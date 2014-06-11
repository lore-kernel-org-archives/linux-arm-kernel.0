From: thunder.leizhen@huawei.com (leizhen)
Date: Wed, 11 Jun 2014 16:12:26 +0800
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <20140606110652.GB4116@e103592.cambridge.arm.com>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <1401975430-2648-2-git-send-email-thunder.leizhen@huawei.com>
 <8620067.9Lo76DOS52@wuerfel>
 <20140606110652.GB4116@e103592.cambridge.arm.com>
Message-ID: <53980F6A.5010209@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/6/6 19:07, Dave Martin wrote:
> On Fri, Jun 06, 2014 at 08:48:26AM +0200, Arnd Bergmann wrote:
>> On Thursday 05 June 2014 21:37:09 Zhen Lei wrote:
>>
>>> +- smmu-masters  : A list of phandles to device nodes representing bus
>>> +                  masters for which the SMMU can provide a translation
>>> +                  and their corresponding StreamIDs (see example below).
>>>
>>
>> We're currently in the process of defining a generic binding for IOMMUs.
>>
>> While the smmu-masters property was copied from an existing binding,
>> I think we will end up migrating away from that towards a common way
>> to express those things, and we shouldn't add another one doing this
>> in a nonstandard way. Please have a look at the latest discussion
>> about the iommu binding using #iommu-cells and a reference from the
>> master to the iommu and see if you can migrate your code to use that.
> 
> Thanks for making this point -- I was going to do so yesterday but then
> hesitated due to uncertainty about whether this should really be a new
> driver.
> 
> Either way, it would be very valuable at least to attempt to describe
> the Hisilicon SMMU implemenation using the new proposals, since that is
> a good test of how reusable the proposed generic binding actually is.
> 
> Cheers
> ---Dave
> 
> .
> 
Thanks. I adjusted my codes these day, I will send a new patch tommorrow.

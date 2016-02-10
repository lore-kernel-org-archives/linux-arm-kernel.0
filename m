From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 10:19:06 +0000
Subject: [PATCH V3 00/10] Introduce ACPI world to GICv3 & ITS irqchip
In-Reply-To: <56BAFAE8.4070308@semihalf.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <56BAFAE8.4070308@semihalf.com>
Message-ID: <56BB0E9A.6010809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomasz,

On 10/02/16 08:55, Tomasz Nowicki wrote:
> On 19.01.2016 14:11, Tomasz Nowicki wrote:
>> Patches base on Suravee's ACPI GICv2m support:
>> https://lkml.org/lkml/2015/12/10/475
>>
>> The following git branch contains submitted patches along with
>> the useful patches from the test point of view (mainly ACPI ARM64 PCI support).
>> https://github.com/semihalf-nowicki-tomasz/linux.git (gicv3-its-acpi-v3)
>>
> 
> Hi Marc,
> 
> Can you please have a look at this series. I think your previous 
> concerns have been addressed.

I've just acked the first 3 patches, which I believe are good to go.

The ITS support is a separate thing, mostly because it introduces a
completely new infrastructure (IORT). I'll review that separately (no
need to resend the patches though).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

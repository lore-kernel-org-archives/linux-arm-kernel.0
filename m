From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Apr 2016 09:01:05 +0100
Subject: [PATCH v5] irqchip, gicv3-its, numa: Enable workaround for Cavium
 thunderx erratum 23144
In-Reply-To: <20160421174042.GD24726@rric.localdomain>
References: <1460748606-28390-1-git-send-email-rrichter@caviumnetworks.com>
 <20160421174042.GD24726@rric.localdomain>
Message-ID: <5719DA41.60304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/16 18:40, Robert Richter wrote:
> On 15.04.16 21:30:05, Robert Richter wrote:
>> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>
>> The erratum fixes the hang of ITS SYNC command by avoiding inter node
>> io and collections/cpu mapping on thunderx dual-socket platform.
>>
>> This fix is only applicable for Cavium's ThunderX dual-socket platform.
>>
>> This is based on NUMA v16 series.
>> Message-Id: <1460155828-8690-1-git-send-email-ddaney.cavm@gmail.com>
> 
> Will, Catalin,
> 
> after NUMA base patches went into linux-next (many thanks), please
> consider this pass 1.x errata workaround for inclusion too.

I'll queue it as a fix once the NUMA patches are merged into mainline.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

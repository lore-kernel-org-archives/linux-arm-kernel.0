From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 18 Nov 2014 08:55:17 +0800
Subject: [RFC PATCH 14/16] arm/PCI: Introduce pci_get_domain_nr()
In-Reply-To: <20141117120839.GA22241@e102568-lin.cambridge.arm.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-15-git-send-email-wangyijing@huawei.com>
 <20141117120839.GA22241@e102568-lin.cambridge.arm.com>
Message-ID: <546A98F5.8080506@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>  
>> -	bus->domain_nr = domain;
>> +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>> +{
>> +	bus->domain_nr = pci_get_domain_nr(parent);
>>  }
>>  #endif
> 
> This code is superseded by the last patches I sent to move the domain
> assignment to PCI core code.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/301220.html

OK, I will update it based the latest one.

> 
> Lorenzo
> 
> 
> .
> 


-- 
Thanks!
Yijing

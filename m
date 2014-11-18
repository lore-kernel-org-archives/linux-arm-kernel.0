From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 18 Nov 2014 20:41:33 +0800
Subject: [RFC PATCH 07/16] PCI: Separate pci_host_bridge creation out
 of pci_create_root_bus()
In-Reply-To: <2911754.xsk2IUfQFO@wuerfel>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1936415.emTbbPeHqx@wuerfel> <546B3124.7070206@huawei.com>
 <2911754.xsk2IUfQFO@wuerfel>
Message-ID: <546B3E7D.4030800@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>> We need, some platforms pass NULL pointer as host bridge parent.
>>>
>>> But those don't have to use the new pci_create_host_bridge() function,
>>> right?
>>
>> As I mentioned in another reply, I hope all pci host drivers could use
>> pci_create_host_bridge(), keep different PCI scan interfaces in PCI core
>> make things become complex.
> 
> Doing this for all platforms that have PCI support would be a lot of
> work though, I think it's better to focus on having a the best interface
> for the majority of users.

Yes.

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing

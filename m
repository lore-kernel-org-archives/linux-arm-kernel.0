From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 27 Oct 2014 09:06:22 +0800
Subject: [PATCH v3 16/27] Mips/MSI: Save msi chip in pci sysdata
In-Reply-To: <20141025130428.GD16738@linux-mips.org>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-17-git-send-email-wangyijing@huawei.com>
 <20141025130428.GD16738@linux-mips.org>
Message-ID: <544D9A8E.6030607@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/10/25 21:04, Ralf Baechle wrote:
> On Wed, Oct 15, 2014 at 11:07:04AM +0800, Yijing Wang wrote:
> 
>> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
>> +{
>> +	struct pci_controller *control = (struct pci_controller *)bus->sysdata;
> 
> bus->sysdata is void * so this cast is unnecessary.

Yes, will update it, thanks!

> 
>   Ralf
> 
> .
> 


-- 
Thanks!
Yijing

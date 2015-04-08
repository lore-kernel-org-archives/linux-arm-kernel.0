From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 8 Apr 2015 16:32:27 +0800
Subject: [PATCH v9 03/30] PCI: Save domain in pci_host_bridge
In-Reply-To: <5524E248.9010509@free-electrons.com>
References: <1428053164-28277-1-git-send-email-wangyijing@huawei.com>
 <1428053164-28277-5-git-send-email-wangyijing@huawei.com>
 <5524E248.9010509@free-electrons.com>
Message-ID: <5524E79B.5020304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/4/8 16:09, Gregory CLEMENT wrote:
> Hi Yijing,
> 
> On 03/04/2015 11:25, Yijing Wang wrote:
>> Save domain in pci_host_bridge, so we could get domain
>> from pci_host_bridge, and at the end of series, we could
>> clean up the arch specific pci_domain_nr(). For arm,
>> we pass -1 as the domain number, we would update the
>> domain number in core by pci_bus_assign_domain_nr().
>>
> For the mvebu part I tested on Armada XP, Armada 375 and Armada 38x
> SoCs, and I didn't saw any regression. So you can add my:
> 
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks a lot for your test!

Thanks!
Yijing.


>>
> 
> 


-- 
Thanks!
Yijing

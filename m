From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 26 Feb 2015 08:54:04 +0800
Subject: [PATCH v2 00/30] Refine PCI scan interfaces and make generic
 pci host bridge
In-Reply-To: <20150225230925.GQ6220@google.com>
References: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
 <20150225230925.GQ6220@google.com>
Message-ID: <54EE6EAC.9070607@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/26 7:09, Bjorn Helgaas wrote:
> On Wed, Jan 21, 2015 at 08:29:55AM +0800, Yijing Wang wrote:
>> v1->v2:
>> 	Split pci_host_bridge_list into a new patch, remove .phb_probe_mode
>> 	and rework powerpc .phb_of_scan_bus() for simpilicty suggested by
>> 	Arnd. Refresh some patch description log, and add a new patch to fix
>> 	build warning in ia64.
>>
>> This series is based on Bjorn's pci-next branch.
> 
> Hi Yijing,
> 
> Would you mind rebasing this to v4.0-rc1?  It doesn't apply quite cleanly
> any more.

OK, I will resend the series based on the v4.0-rc1.

Thanks!
Yijing.

> 
> Thanks,
>   Bjorn
> 
> .
> 


-- 
Thanks!
Yijing

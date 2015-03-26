From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 26 Mar 2015 15:30:44 +0800
Subject: [PATCH v6 04/30] xen/PCI: Don't use deprecated function
 pci_scan_bus_parented()
In-Reply-To: <20150325192331.GG25884@l.oracle.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <1425868467-9667-5-git-send-email-wangyijing@huawei.com>
 <20150311223211.GB1082@google.com> <55017CA5.2010502@huawei.com>
 <20150312193505.GB7346@google.com> <55024D35.6050509@huawei.com>
 <CAErSpo4T7f9PNVMLrQbCvW2a=HnRauQR2eBz6H69B7Q2=ELNWw@mail.gmail.com>
 <20150313140132.GH5378@l.oracle.com>
 <CAErSpo69ytCxBK5AD79Nz05wy=GwzcOGV7WkiKFxpLDH4wtJXw@mail.gmail.com>
 <20150325192331.GG25884@l.oracle.com>
Message-ID: <5513B5A4.1070209@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> Is there an git tree with this so I can just try it out?
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>> pci/enumeration-yw6 has similar code (it exports the single
> 
> I presume now it is bjorn/pci/enumeration-yw8 ? Going to test this out
> this week.

Hi Konrad, I fixed two issues found by Tomasz and Daniel for the current v8 version.
I posted out the latest v9 in my github tree. Could you pull this series from my
github tree ?
The URL is: https://github.com/YijingWang/linux-pci.git enumer9

Thanks!
Yijing.

>> busn_resource and makes xen use it).  That should be functionally
>> identical to what v4.0-rc1 does.
>>
>> Yijing hasn't posted the static busn_res proposal above yet, so I
>> don't have a branch with that in it.
>>
>> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing

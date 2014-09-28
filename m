From: wangyijing@huawei.com (Yijing Wang)
Date: Sun, 28 Sep 2014 10:32:07 +0800
Subject: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
In-Reply-To: <20140926090537.GH31106@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo> <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo> <20140925171612.GC31157@bart.dudau.co.uk>
 <542505B3.7040208@huawei.com> <20140926085430.GG31106@ulmo>
 <20140926090537.GH31106@ulmo>
Message-ID: <54277327.6070500@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/26 17:05, Thierry Reding wrote:
> On Fri, Sep 26, 2014 at 10:54:32AM +0200, Thierry Reding wrote:
> [...]
>> At least for Tegra it's trivial to just hook it up in tegra_pcie_scan_bus()
>> directly (patch attached).
> 
> Really attached this time.
> 
> Thierry
> 

It looks good to me, so I will update the arm pci hostbridge driver to assign
pci root bus the msi chip instead of current pcibios_add_bus(). But for other
platforms which only have a one msi chip, I will kept the arch_find_msi_chip()
temporarily for more comments, especially from Bjorn.

Thanks!
Yijing.

-- 
Thanks!
Yijing

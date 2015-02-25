From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 25 Feb 2015 17:09:25 -0600
Subject: [PATCH v2 00/30] Refine PCI scan interfaces and make generic pci
 host bridge
In-Reply-To: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
References: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
Message-ID: <20150225230925.GQ6220@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 08:29:55AM +0800, Yijing Wang wrote:
> v1->v2:
> 	Split pci_host_bridge_list into a new patch, remove .phb_probe_mode
> 	and rework powerpc .phb_of_scan_bus() for simpilicty suggested by
> 	Arnd. Refresh some patch description log, and add a new patch to fix
> 	build warning in ia64.
> 
> This series is based on Bjorn's pci-next branch.

Hi Yijing,

Would you mind rebasing this to v4.0-rc1?  It doesn't apply quite cleanly
any more.

Thanks,
  Bjorn

From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 12 Jun 2017 17:20:36 +0100
Subject: [RFT PATCH v2 00/42] PCI: ARM/ARM64: remove pci_fixup_irqs() usage
In-Reply-To: <20170612154537.GC22710@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170612154537.GC22710@arm.com>
Message-ID: <20170612162036.GB32043@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 04:45:38PM +0100, Will Deacon wrote:
> On Thu, Jun 08, 2017 at 03:13:00PM +0100, Lorenzo Pieralisi wrote:
> > v1 -> v2
> > 
> > - Split pci_fixup_irqs() removal in several patches
> > - Embedded pci_register_host_bridge() in pci_scan_root_bus_bridge()
> > - Refactored iproc, faraday and xilinx-nwl host bridges in preparation
> >   for irq fixup removal
> > - Converted all DT PCI host bridge drivers to pci_scan_root_bus_bridge()
> > - Dropped RFC tag
> > - Added devm_pci_alloc_host_bridge() interface
> > - Rebased against v4.12-rc3
> 
> For the arm64 and the host-common bits:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thank you !
Lorenzo

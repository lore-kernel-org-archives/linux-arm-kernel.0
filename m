From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 18 Apr 2018 14:02:30 +0100
Subject: [PATCH v4 0/6] PCI: aardvark: misc fixes and improvements
In-Reply-To: <20180409205433.4eb78a45@windsurf>
References: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
 <20180409162356.GB14533@e107981-ln.cambridge.arm.com>
 <20180409205433.4eb78a45@windsurf>
Message-ID: <20180418130230.GB22463@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 08:54:33PM +0200, Thomas Petazzoni wrote:
> Hello Lorenzo,
> 
> Thanks for your feedback!
> 
> On Mon, 9 Apr 2018 17:23:56 +0100, Lorenzo Pieralisi wrote:
> 
> > it is not just improvements, these look like significant bug fixes too.
> > 
> > Let me know which patches we should prioritize since hopefully they can
> > be sent during v4.17-rc* releases, I will queue the rest for the next
> > merge window.
> 
> The patches that are bug fixes are marked with a "Fixes:" tag and are
> Cc'ed to stable.
> 
> So, the following patches are fixes:
> 
> [PATCH v4 1/6] PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
> [PATCH v4 2/6] PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
> [PATCH v4 3/6] PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode
> [PATCH v4 4/6] PCI: aardvark: Fix PCIe Max Read Request Size setting
> 
> The following patches are improvements:
> 
> [PATCH v4 5/6] PCI: aardvark: Introduce an advk_pcie_valid_device() helper
> [PATCH v4 6/6] PCI: aardvark: Remove PCIe outbound window configuration

I added those four patches to my pci/host/fixes branch, please have a
look if they meet your expectations and if so I will ask Bjorn to send
them if he thinks they are fit for -rc*.

Thanks,
Lorenzo

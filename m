From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 18 Apr 2018 15:49:54 +0200
Subject: [PATCH v4 0/6] PCI: aardvark: misc fixes and improvements
In-Reply-To: <20180418130230.GB22463@e107981-ln.cambridge.arm.com>
References: <20180406145536.19637-1-thomas.petazzoni@bootlin.com>
 <20180409162356.GB14533@e107981-ln.cambridge.arm.com>
 <20180409205433.4eb78a45@windsurf>
 <20180418130230.GB22463@e107981-ln.cambridge.arm.com>
Message-ID: <20180418154954.2a68fce6@windsurf.numericable.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 18 Apr 2018 14:02:30 +0100, Lorenzo Pieralisi wrote:

> > So, the following patches are fixes:
> > 
> > [PATCH v4 1/6] PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
> > [PATCH v4 2/6] PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
> > [PATCH v4 3/6] PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode
> > [PATCH v4 4/6] PCI: aardvark: Fix PCIe Max Read Request Size setting
> > 
> > The following patches are improvements:
> > 
> > [PATCH v4 5/6] PCI: aardvark: Introduce an advk_pcie_valid_device() helper
> > [PATCH v4 6/6] PCI: aardvark: Remove PCIe outbound window configuration  
> 
> I added those four patches to my pci/host/fixes branch, please have a
> look if they meet your expectations and if so I will ask Bjorn to send
> them if he thinks they are fit for -rc*.

Looks good to me. Those four patches are indeed the ones that would
ideally be sent during the -rc cycle. Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

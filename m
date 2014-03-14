From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Mar 2014 18:38:08 +0100
Subject: [PATCH v7 3/3] arm64: Add architecture support for PCI
In-Reply-To: <20140314171457.GK18126@arm.com>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811258-1500-4-git-send-email-Liviu.Dudau@arm.com>
 <20140314171457.GK18126@arm.com>
Message-ID: <201403141838.08900.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 March 2014, Catalin Marinas wrote:
> On Fri, Mar 14, 2014 at 03:34:18PM +0000, Liviu Dudau wrote:
> > --- /dev/null
> > +++ b/arch/arm64/kernel/pci.c
> [...]
> > +int pci_register_io_range(phys_addr_t address, resource_size_t size)
> [...]
> > +unsigned long pci_address_to_pio(phys_addr_t address)
> [...]
> > +void pcibios_fixup_bus(struct pci_bus *bus)
> [ actually most of this file ]
> 
> Maybe it was raised before already but can we have __weak generic
> definitions of these functions? They don't seem to be arm64 specific in
> any way.
> 

I would definitely prefer that.

	Arnd

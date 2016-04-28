From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Apr 2016 14:13:36 +0200
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
In-Reply-To: <20160428120624.GV28464@e106497-lin.cambridge.arm.com>
References: <20160427225827.GC17629@localhost>
 <20160428120624.GV28464@e106497-lin.cambridge.arm.com>
Message-ID: <20160428141336.60aa4be1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 28 Apr 2016 13:06:24 +0100, Liviu Dudau wrote:

> I am OK with the suggestion that Thomas has to add a parameter to
> pci_remap_iospace() to pass on the pgprot_t value one wants and get rid of
> pci_remap_io(), but I would suggest first to him to convert the ARMADA XP
> platform to generic PCI code and see if it doesn't work OK by default. We
> (well, Lorenzo driven nowadays) are pushing in that direction for a while now.

Armada XP itself is not affected by the HW issue that requires use to
use strongly-ordered mappings, it's only the Cortex-A9 based SoC, i.e
Armada 375, 38x and 39x.

That being said, could you point to me to which bits of the generic PCI
code I should convert our PCI support to? I'd be happy to take a look.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

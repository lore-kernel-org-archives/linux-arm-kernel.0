From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 May 2014 11:09:11 +0100
Subject: [PATCHv5 4/4] ARM: mvebu: use pci_ioremap_set_mem_type() to map
 PCI I/O as strongly ordered
In-Reply-To: <1400487234-4501-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400487234-4501-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400487234-4501-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140519100911.GF5113@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 09:13:54AM +0100, Thomas Petazzoni wrote:
> Part of the workaround for the PCIe/SMP/PL310 deadlock on Armada
> 375/38x is to map PCI mappings strongly ordered. Mapping PCI memory
> regions as strongly ordered was already done thanks to the
> arch_ioremap_caller mechanism. This patch does the same for the PCI
> I/O regions by using the new pci_ioremap_set_mem_type() function.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

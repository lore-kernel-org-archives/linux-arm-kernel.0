From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 02 Oct 2015 16:11:12 +0100
Subject: [PATCH v4 3/4] PCI/MSI: Add helper function
 pci_msi_domain_get_msi_rid().
In-Reply-To: <1443747025-9918-4-git-send-email-ddaney.cavm@gmail.com>
References: <1443747025-9918-1-git-send-email-ddaney.cavm@gmail.com>
 <1443747025-9918-4-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <560E9E90.6000709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 01:50, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Add pci_msi_domain_get_msi_rid() to return the MSI requester id (RID).
> Initially needed by gic-v3 based systems. It will be used by follow on
> patch to drivers/irqchip/irq-gic-v3-its-pci-msi.c
> 
> Initially supports mapping the RID via OF device tree.  In the future,
> this could be extended to use ACPI _IORT tables as well.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

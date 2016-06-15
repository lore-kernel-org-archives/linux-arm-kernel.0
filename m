From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Jun 2016 09:33:03 +0100
Subject: [PATCH V6 2/7] PCI/MSI: Setup MSI domain on a per-devices basis
 using IORT ACPI table
In-Reply-To: <1465828873-23498-3-git-send-email-tn@semihalf.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <1465828873-23498-3-git-send-email-tn@semihalf.com>
Message-ID: <20160615093303.1dd3fee1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2016 16:41:08 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

> It is possible to provide information about which MSI controller to
> use on a per-device basis for DT. This patch supply this with ACPI support.
> 
> Currently, IORT is the only one ACPI table which can provide such mapping.
> In order to plug IORT into MSI infrastructure we are adding ACPI
> equivalents for finding PCI device domain and its RID translation
> (pci_msi_domain_get_msi_rid and pci_msi_domain_get_msi_rid calls).
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.

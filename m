From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Jul 2015 17:54:33 +0100
Subject: [PATCH v2 1/2] ARM: PCI: bios32: replace panic with WARN messages
 on failures
In-Reply-To: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <55B26DC9.8010408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/15 17:13, Lorenzo Pieralisi wrote:
> In the ARM PCI bios32 layer, failures to dynamically allocate pci_sys_data
> for a PCI bus, or a PCI bus scan failure have to be considered serious
> warnings but they should not trigger a system panic so that at least the
> system is given a chance to be debugged.
> 
> This patch replaces the panic statements with WARN() messages to
> improve error reporting in the ARM PCI bios32 layer.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

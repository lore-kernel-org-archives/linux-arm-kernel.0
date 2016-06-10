From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 10 Jun 2016 18:41:07 -0500
Subject: [PATCH V9 00/11] Support for ARM64 ACPI based PCI host controller
In-Reply-To: <1465588519-11334-1-git-send-email-tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
Message-ID: <20160610234107.GC7671@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 09:55:08PM +0200, Tomasz Nowicki wrote:
> From the functionality point of view this series may be split into the
> following logic parts:
> 1. Export ECAM API and add parent device to pci_config_window
> 2. Add IO resources handling to PCI core code
> 3. New MCFG driver
> 4. Cleanups and support for generic domain assignment based on ACPI
> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/

This is beautiful!  It really turned out well.

I applied all these to pci/arm64-acpi for v4.8.

Bjorn

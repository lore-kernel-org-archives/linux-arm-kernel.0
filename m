From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 8 Oct 2018 12:31:31 -0500
Subject: [PATCH v6 0/9] PCI: mediatek: fixup find_port, enable_msi and
 add pm, module support
In-Reply-To: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20181008173131.GN120535@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 11:24:39AM +0800, honghui.zhang at mediatek.com wrote:

> Honghui Zhang (9):
>   PCI: mediatek: Using slot's devfn for compare to fix
>     mtk_pcie_find_port logic
>   PCI: mediatek: Fixup class ID for MT7622 as PCI_CLASS_BRIDGE_PCI
>   PCI: mediatek: Remove the redundant dev->pm_domain check
>   PCI: mediatek: Convert to use pci_host_probe()
>   PCI: mediatek: Move the mtk_pcie_startup_port_v2 function's define
>     after mtk_pcie_setup_irq
>   PCI: mediatek: Fixup enable msi logic by enable msi after clock
>     enabled

s/msi/MSI/ (twice)

>   PCI: mediatek: Add system pm support for MT2712 and MT7622

s/pm/PM/

"msi" and "pm" are not English words, and capitalizing them tells the
reader that they are acronyms or initialisms (like GIC and IRQ below).

>   PCI: mediatek: Save the GIC IRQ in mtk_pcie_port
>   PCI: mediatek: Add loadable kernel module support

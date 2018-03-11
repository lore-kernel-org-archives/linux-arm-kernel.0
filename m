From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 11 Mar 2018 23:04:15 +0100
Subject: [PATCH v3 00/15] add dts nodes to MT7622 SoC
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
Message-ID: <9c34bec9-87af-153a-6bff-9138fd8d62e7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/17/2018 08:54 PM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Changes since v2:
> - rebase to 4.16-rc1 and solve all conflicts
> - add proper list Cc in patch 1
> - add fixup in patch 4 in v2 with the uniform pinmux definition
>   that is always adding property function before property groups
> - add Acked-by from Philippe in patch 5
> - add clock related property into all CPU nodes in patch 6
> - merge patch 14 in v2 into patch 8 as this is where the node is
>   defined in the first place
> 
> Changes since v1:
> - add usb, thermal, HSDMA, mmc related nodes
> - fix Warning (unit_address_vs_reg): Node /oscillator at 0 has
>   a unit name, but no reg property in patch 2
> - fix Warning (pci_bridge): Node /pcie at 1a140000/pcie at 0,0 missing
>   bus-range for PCI bridge
> - fix Warning (pci_bridge): Node /pcie at 1a140000/pcie at 1,0 missing
>   bus-range for PCI bridge
> - fix Warning (unit_address_format): Failed prerequisite 'pci_bridge'
> - fix Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
> - fix Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> - enhance commit log in patch 4
> - use - instead of _ in DT node name in patch 4 and 6
> - use SPDX-License-Identifier for newly added files in patch 5
> - use proper #size-cells for spi nor nodes in patch 9
> - remove currently no needed #address-cells and #size-cells in
> children nodes of spi nor in patch 9.
> 

Pushed 2-13 and 15 to v4.16-next/dts64

Thanks a lot.
Matthias

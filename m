From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Feb 2018 21:10:59 -0600
Subject: [PATCH] dt-bindings: PCI: MediaTek: fix dtc warnings
In-Reply-To: <9940757fe2889f46d0de214c5f277bf3c2074205.1518577579.git.ryder.lee@mediatek.com>
References: <9940757fe2889f46d0de214c5f277bf3c2074205.1518577579.git.ryder.lee@mediatek.com>
Message-ID: <20180219031059.jdv3q4big6c4ra7p@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 11:27:58AM +0800, Ryder Lee wrote:
> dtc recently added PCI bus checks. Fix these warnings:
> 
> Warning (pci_bridge): Node /pcie at 1a140000/pcie at 0,0 missing bus-range for PCI bridge
> Warning (pci_bridge): Node /pcie at 1a140000/pcie at 1,0 missing bus-range for PCI bridge
> Warning (pci_bridge): Node /pcie at 1a140000/pcie at 2,0 missing bus-range for PCI bridge
> Warning (unit_address_format): Failed prerequisite 'pci_bridge'
> Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
> Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

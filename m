From: robh@kernel.org (Rob Herring)
Date: Thu, 25 Oct 2018 16:51:37 -0500
Subject: [PATCH v2 2/4] dt-bindings: pci: layerscape-pci: removed
 compatible  string "snps,dw-pcie"
In-Reply-To: <20181025094929.29481-3-Zhiqiang.Hou@nxp.com>
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
 <20181025094929.29481-3-Zhiqiang.Hou@nxp.com>
Message-ID: <20181025215137.GA14643@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2018 09:49:39 +0000, "Z.q. Hou" wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Removed the compatible string "snps,dw-pcie", it is for the reference
> platform driver for PCI RC IP Protoyping Kits based on the ARC SDP,
> so it is not suitable for all platform with designware PCIe controller,
> and platform vendors have themselves' drivers.
> 
> The compatible string "snsp,dw-pcie" was added by mistake and it's not
> matched that time, but it is matched because PCIe drivers has been
> collected recently.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Improved the subject.
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

From: robh@kernel.org (Rob Herring)
Date: Thu, 25 Oct 2018 16:50:56 -0500
Subject: [PATCH v2 1/4] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1043a-pcie"
In-Reply-To: <20181025094929.29481-2-Zhiqiang.Hou@nxp.com>
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
 <20181025094929.29481-2-Zhiqiang.Hou@nxp.com>
Message-ID: <20181025215056.GA13567@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2018 09:49:34 +0000, "Z.q. Hou" wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The PCIe compatible string for LS1043A was lost, so add it.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Improved the subject and corrected 'PCIe' casing.
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

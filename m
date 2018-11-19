From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 19 Nov 2018 20:01:25 +0800
Subject: [PATCHv3 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
In-Reply-To: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
References: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181119120123.GQ5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 05:35:12AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Removed the compatible string "snps,dw-pcie" from FSL layerscape-pci compatible
> string list.
> 
> Hou Zhiqiang (4):
>   dt-bindings: pci: layerscape-pci: add compatible strings
>     "fsl,ls1043a-pcie"
>   dt-bindings: pci: layerscape-pci: removed compatible string
>     "snps,dw-pcie"
>   ARM: dts: ls1021a: removed compatible string "snps,dw-pcie"
>   arm64: dts: layerscape: removed compatible string "snps,dw-pcie"

Applied all, thanks.

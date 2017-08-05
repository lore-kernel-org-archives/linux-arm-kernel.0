From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Aug 2017 13:46:29 +0800
Subject: [PATCHv2 0/3] dts: add ls2088a and 1088a pcie DT nodes
In-Reply-To: <1501829046-3761-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1501829046-3761-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <20170805054627.GU31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 02:44:03PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add GICv3 ITS DT node for ls1088a, because the PCIe nodes must
> have a msi-parent.
> 
> Hou Zhiqiang (3):
>   dts: ls2088a: add pcie support
>   dts: ls1088a: add gicv3 ITS DT node
>   dts: ls1088a: add PCIe controller DT nodes

Please have an additional 'arm64: ' prefix for these arm64 dts patches.

Shawn

> 
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 81 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  4 ++
>  2 files changed, 85 insertions(+)

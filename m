From: robh@kernel.org (Rob Herring)
Date: Mon, 7 May 2018 12:04:35 -0500
Subject: [PATCH v2 1/2] dt-bindings: add MediaTek XS-PHY binding
In-Reply-To: <1525486506-19301-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1525486506-19301-1-git-send-email-chunfeng.yun@mediatek.com>
 <1525486506-19301-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20180507170435.GA14540@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2018 at 10:15:05AM +0800, Chunfeng Yun wrote:
> Add a DT binding documentation of XS-PHY for MediaTek SoCs
> with USB3.1 GEN2 controller
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  110 ++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> new file mode 100644
> index 0000000..9a95fab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> @@ -0,0 +1,110 @@
> +MediaTek XS-PHY binding
> +--------------------------
> +
> +The XS-PHY controller supports physical layer functionality for USB3.1
> +GEN2 controller on MediaTek SoCs.
> +
> +Required properties (controller (parent) node):
> + - compatible	: should be "mediatek,<soc-model>-xsphy", "mediatek,xsphy",
> + 		  soc-model is the name of SoC, such as mt2712 etc;
> +		  when using "mediatek,xsphy" compatible string, you need SoC specific
> +		  ones in addition, one of:
> +		  - "mediatek,mt3611-xsphy"

What about mt2712 you mention above?

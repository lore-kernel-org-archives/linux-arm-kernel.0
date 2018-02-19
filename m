From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 14:31:52 -0600
Subject: [PATCH v5 1/3] dt-bindings: dmaengine: Add MediaTek High-Speed
 DMA controller bindings
In-Reply-To: <94e4a39e05a30f2ca3fafb61d19777f41fa49645.1518857747.git.sean.wang@mediatek.com>
References: <cover.1518857746.git.sean.wang@mediatek.com>
 <94e4a39e05a30f2ca3fafb61d19777f41fa49645.1518857747.git.sean.wang@mediatek.com>
Message-ID: <20180219203152.xujjsolbe24ec66q@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 18, 2018 at 03:08:29AM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Document the devicetree bindings for MediaTek High-Speed DMA controller
> which could be found on MT7623 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-hsdma.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt

Reviewed-by: Rob Herring <robh@kernel.org>

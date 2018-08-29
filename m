From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Aug 2018 19:36:39 -0500
Subject: [PATCH v2 1/2] dt-bindings: dmaengine: add DT binding for
 UniPhier MIO DMAC
In-Reply-To: <1535074873-15617-2-git-send-email-yamada.masahiro@socionext.com>
References: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
 <1535074873-15617-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20180829003639.GA24691@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Aug 2018 10:41:12 +0900, Masahiro Yamada wrote:
> The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
> Pro4, and sLD8 SoCs.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>  - Rename the node "dmac" to "dma-controller"
>  - Remove dma-channels property
> 
>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

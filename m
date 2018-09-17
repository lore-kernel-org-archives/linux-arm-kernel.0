From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:44:54 -0400
Subject: [PATCH 1/2] dt-bindings: dmaengine: Add MediaTek Command-Queue
 DMA controller bindings
In-Reply-To: <1536050626-21927-2-git-send-email-shun-chih.yu@mediatek.com>
References: <1536050626-21927-1-git-send-email-shun-chih.yu@mediatek.com>
 <1536050626-21927-2-git-send-email-shun-chih.yu@mediatek.com>
Message-ID: <5b9f3f57.1c69fb81.17be4.3001@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Sep 2018 16:43:45 +0800, <shun-chih.yu@mediatek.com> wrote:
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> 
> Document the devicetree bindings for MediaTek Command-Queue DMA controller
> which could be found on MT6765 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

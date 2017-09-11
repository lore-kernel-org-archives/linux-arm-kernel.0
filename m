From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Sep 2017 15:57:08 -0500
Subject: [PATCH v3 2/3] dt-bindings: mt8173-xhci: add generic compatible
 and rename file
In-Reply-To: <0ef0bfd4f2544e57c7bdaea518c3fc75ae40b74f.1504092763.git.chunfeng.yun@mediatek.com>
References: <33fa448238c0d95f0cfd6c2be3bd5c4e657a0cd4.1504092763.git.chunfeng.yun@mediatek.com>
 <0ef0bfd4f2544e57c7bdaea518c3fc75ae40b74f.1504092763.git.chunfeng.yun@mediatek.com>
Message-ID: <20170911205708.jh2y74asqvffgy4g@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 07:34:10PM +0800, Chunfeng Yun wrote:
> The mt8173-xhci.txt actually holds the bindings for all mediatek
> SoCs with xHCI controller, so add a generic compatible and change
> the name to mediatek,mtk-xhci.txt to reflect that.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../usb/{mt8173-xhci.txt => mediatek,mtk-xhci.txt} |   14 +++++++++++---
>  .../devicetree/bindings/usb/mt8173-mtu3.txt        |    2 +-
>  2 files changed, 12 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/usb/{mt8173-xhci.txt => mediatek,mtk-xhci.txt} (85%)

Acked-by: Rob Herring <robh@kernel.org>

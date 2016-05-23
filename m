From: robh@kernel.org (Rob Herring)
Date: Mon, 23 May 2016 10:41:38 -0500
Subject: [PATCH v2 1/5] dt-bindings: mediatek: add descriptions for
 mediatek mt2701 iommu and smi
In-Reply-To: <1463658558-567-2-git-send-email-honghui.zhang@mediatek.com>
References: <1463658558-567-1-git-send-email-honghui.zhang@mediatek.com>
 <1463658558-567-2-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20160523154138.GA31426@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 07:49:14PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> This patch defines the local arbitor port IDs for mediatek SoC MT2701 and
> add descriptions of binding for mediatek generation one iommu and smi.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   | 13 +++-
>  .../memory-controllers/mediatek,smi-common.txt     | 21 +++++-
>  .../memory-controllers/mediatek,smi-larb.txt       |  4 +-
>  include/dt-bindings/memory/mt2701-larb-port.h      | 85 ++++++++++++++++++++++
>  4 files changed, 115 insertions(+), 8 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt2701-larb-port.h

Acked-by: Rob Herring <robh@kernel.org>

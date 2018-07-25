From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Jul 2018 08:47:16 -0600
Subject: [PATCH v23 1/4] dt-bindings: soc: Add documentation for the
 MediaTek GCE unit
In-Reply-To: <1532482002-11164-2-git-send-email-houlong.wei@mediatek.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
 <1532482002-11164-2-git-send-email-houlong.wei@mediatek.com>
Message-ID: <20180725144716.GA29676@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 09:26:39AM +0800, Houlong Wei wrote:
> This adds documentation for the MediaTek Global Command Engine (GCE) unit
> found in MT8173 SoCs.
> 
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |   57 ++++++++++++++++++++
>  include/dt-bindings/gce/mt8173-gce.h               |   44 +++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
>  create mode 100644 include/dt-bindings/gce/mt8173-gce.h

Reviewed-by: Rob Herring <robh@kernel.org>

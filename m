From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Jan 2016 16:00:19 -0600
Subject: [PATCH v8 2/5] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <1453781562-23556-3-git-send-email-yong.wu@mediatek.com>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-3-git-send-email-yong.wu@mediatek.com>
Message-ID: <20160126220019.GA23765@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 12:12:39PM +0800, Yong Wu wrote:
> This patch add smi binding document and smi local arbiter header file.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.txt     |  24 +++++
>  .../memory-controllers/mediatek,smi-larb.txt       |  25 +++++
>  include/dt-bindings/memory/mt8173-larb-port.h      | 111 +++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h

Acked-by: Rob Herring <robh@kernel.org>

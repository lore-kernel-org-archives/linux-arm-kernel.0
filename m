From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Sep 2017 16:44:29 -0500
Subject: [PATCH 1/4] dt-bindings: clock: mediatek: document clk bindings
 for MediaTek MT7622 SoC
In-Reply-To: <3a6338ca5f1513b897cac2facc7c0bf796b8c64f.1505890481.git.sean.wang@mediatek.com>
References: <cover.1505890481.git.sean.wang@mediatek.com>
 <3a6338ca5f1513b897cac2facc7c0bf796b8c64f.1505890481.git.sean.wang@mediatek.com>
Message-ID: <20170927214429.2w7s3f7zpqr4kkvs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 05:49:25PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch adds the binding documentation for apmixedsys, ethsys, hifsys,
> infracfg, pericfg, topckgen and audsys for MT7622.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt      | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,ethsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,hifsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,pciesys.txt     | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,pericfg.txt     |  1 +
>  .../bindings/arm/mediatek/mediatek,sgmiisys.txt    | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,ssusbsys.txt    | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
>  10 files changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt

Acked-by: Rob Herring <robh@kernel.org>

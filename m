From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 16:04:45 -0500
Subject: [PATCH v1 1/9] dt-bindings: ARM: Mediatek: Document bindings for
 MT2712
In-Reply-To: <1502779370-30150-2-git-send-email-weiyi.lu@mediatek.com>
References: <1502779370-30150-1-git-send-email-weiyi.lu@mediatek.com>
 <1502779370-30150-2-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <20170817210445.y34gpxbqixt6qswr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 02:42:42PM +0800, weiyi.lu at mediatek.com wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> This patch adds the binding documentation for apmixedsys, bdpsys,
> imgsys, imgsys, infracfg, mcucfg, mfgcfg, mmsys, pericfg, topckgen,
> vdecsys and vencsys for Mediatek MT2712.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
>  .../bindings/arm/mediatek/mediatek,bdpsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,jpgdecsys.txt   | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mcucfg.txt      | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mfgcfg.txt      | 22 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  1 +
>  .../bindings/arm/mediatek/mediatek,pericfg.txt     |  1 +
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  1 +
>  .../bindings/arm/mediatek/mediatek,vencsys.txt     |  1 +
>  12 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,jpgdecsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mcucfg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt

Acked-by: Rob Herring <robh@kernel.org>

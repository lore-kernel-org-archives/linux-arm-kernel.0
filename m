From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Feb 2016 13:24:28 -0600
Subject: [PATCH v6 2/7] dt-bindings: ARM: Mediatek: Document bindings for
 MT2701
In-Reply-To: <1454665050-37776-3-git-send-email-jamesjj.liao@mediatek.com>
References: <1454665050-37776-1-git-send-email-jamesjj.liao@mediatek.com>
 <1454665050-37776-3-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20160208192428.GA26367@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 05:37:25PM +0800, James Liao wrote:
> This patch adds the binding documentation for apmixedsys, bdpsys,
> ethsys, hifsys, imgsys, infracfg, mmsys, pericfg, topckgen and
> vdecsys for Mediatek MT2701.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Tested-by: John Crispin <blogic@openwrt.org>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  3 ++-
>  .../bindings/arm/mediatek/mediatek,bdpsys.txt      | 22 ++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,ethsys.txt      | 22 ++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,hifsys.txt      | 24 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |  3 ++-
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |  3 ++-
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  3 ++-
>  .../bindings/arm/mediatek/mediatek,pericfg.txt     |  3 ++-
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |  3 ++-
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  3 ++-
>  10 files changed, 82 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt

Acked-by: Rob Herring <robh@kernel.org>

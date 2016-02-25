From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 25 Feb 2016 16:50:07 +0100
Subject: [PATCH v10 0/5] MT8173 IOMMU SUPPORT
In-Reply-To: <1456161651-6136-1-git-send-email-yong.wu@mediatek.com>
References: <1456161651-6136-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <20160225155007.GA19092@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 01:20:46AM +0800, Yong Wu wrote:
> Yong Wu (5):
>   dt-bindings: iommu: Add binding for mediatek IOMMU
>   dt-bindings: mediatek: Add smi dts binding
>   memory: mediatek: Add SMI driver
>   iommu/mediatek: Add mt8173 IOMMU driver
>   dts: mt8173: Add iommu/smi nodes for mt8173
> 
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  68 ++
>  .../memory-controllers/mediatek,smi-common.txt     |  24 +
>  .../memory-controllers/mediatek,smi-larb.txt       |  25 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  81 +++
>  drivers/iommu/Kconfig                              |  16 +
>  drivers/iommu/Makefile                             |   1 +
>  drivers/iommu/mtk_iommu.c                          | 737 +++++++++++++++++++++
>  drivers/memory/Kconfig                             |   8 +
>  drivers/memory/Makefile                            |   1 +
>  drivers/memory/mtk-smi.c                           | 273 ++++++++
>  include/dt-bindings/memory/mt8173-larb-port.h      | 111 ++++
>  include/soc/mediatek/smi.h                         |  58 ++
>  12 files changed, 1403 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 drivers/iommu/mtk_iommu.c
>  create mode 100644 drivers/memory/mtk-smi.c
>  create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h
>  create mode 100644 include/soc/mediatek/smi.h

Applied all, thanks.

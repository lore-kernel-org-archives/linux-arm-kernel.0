From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 18 Jul 2018 15:54:46 +0200
Subject: [PATCH v4] dt-bindings: mediatek: Add binding for mt2712 IOMMU
 and SMI
In-Reply-To: <d3d34d21-1a38-d3b7-1448-bd9e4c6afc6e@gmail.com>
References: <1527165331-22261-1-git-send-email-yong.wu@mediatek.com>
 <1529562433.22229.2.camel@mhfsdcap03>
 <d3d34d21-1a38-d3b7-1448-bd9e4c6afc6e@gmail.com>
Message-ID: <20180718135446.GB18541@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:28:14PM +0200, Matthias Brugger wrote:
> >>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  6 +-
> >>  .../memory-controllers/mediatek,smi-common.txt     |  6 +-
> >>  .../memory-controllers/mediatek,smi-larb.txt       |  5 +-
> >>  include/dt-bindings/memory/mt2712-larb-port.h      | 95 ++++++++++++++++++++++
> >>  4 files changed, 106 insertions(+), 6 deletions(-)
> >>  create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h
> >>
> 
> Joerg, will you take this through your tree, or would you mind to provide a
> Acked-By?

Sure,

	Acked-by: Joerg Roedel <jroedel@suse.de>

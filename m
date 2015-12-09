From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 9 Dec 2015 14:55:44 +0800
Subject: [PATCH v6 1/5] dt-bindings: iommu: Add binding for mediatek IOMMU
In-Reply-To: <20151209033302.GA12091@rob-hp-laptop>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
 <1449568153-15643-2-git-send-email-yong.wu@mediatek.com>
 <20151209033302.GA12091@rob-hp-laptop>
Message-ID: <1449644144.14761.44.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

also add Mark.

On Tue, 2015-12-08 at 21:33 -0600, Rob Herring wrote:
> On Tue, Dec 08, 2015 at 05:49:09PM +0800, Yong Wu wrote:
> > This patch add mediatek iommu dts binding document.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  68 +++++++++++++
> >  include/dt-bindings/memory/mt8173-larb-port.h      | 111 +++++++++++++++++++++
> 
> This should be iommu rather than memory.

Hi Rob,
   Thanks very much for review.

   From the HW, all the larbs and ports are defined in the SMI.
About the position of the SMI code, We also discussed before in [1].
So I put the header file in /dt-bindings/memory/.

This is a smi larb-port header file, maybe we should move this header
file into this patch:
[2/5] dt-bindings: mediatek: Add smi dts binding

is it ok if we move it into [2/5]?

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000121.html

> 
> Otherwise, it looks okay to me.

Thanks.

> 
> >  2 files changed, 179 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> >  create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h

From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 22 Jun 2016 13:45:42 +0800
Subject: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
 mt2701
In-Reply-To: <20160621095748.GE28248@8bytes.org>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
 <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
 <20160621095748.GE28248@8bytes.org>
Message-ID: <1466574342.27791.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-06-21 at 17:57 +0800, Joerg Roedel wrote:
> On Wed, Jun 08, 2016 at 05:51:01PM +0800, honghui.zhang at mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > Add the dtsi node of iommu and smi for mt2701.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt2701.dtsi | 51 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> 
> Okay, I pushed my arm/mediatek branch to my tree at
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> 
> Please base the patch on that branch and re-send.
> 

I think it is better let Mediatek SoC maintainer Matthias to accept dtsi
patch like other drivers. This can avoid dtsi conflict. As I
remember,last time MT8173 IOMMU dtsi patch accepted in iommu tree and
mt8173.dtsi had conflict with arm soc tree at the merge window. Honghui
should resend this patch to Matthias, and elaborate your dependency with
clock and power domain dtsi, then Matthias know the merge sequence. 

Eddie
Thanks

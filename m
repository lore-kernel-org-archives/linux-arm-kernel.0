From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Wed, 22 Jun 2016 15:45:47 +0800
Subject: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
 mt2701
In-Reply-To: <1466574342.27791.8.camel@mtksdaap41>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
 <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
 <20160621095748.GE28248@8bytes.org> <1466574342.27791.8.camel@mtksdaap41>
Message-ID: <1466581547.8787.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-06-22 at 13:45 +0800, Eddie Huang wrote:
> On Tue, 2016-06-21 at 17:57 +0800, Joerg Roedel wrote:
> > On Wed, Jun 08, 2016 at 05:51:01PM +0800, honghui.zhang at mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > Add the dtsi node of iommu and smi for mt2701.
> > > 
> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  arch/arm/boot/dts/mt2701.dtsi | 51 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > 
> > Okay, I pushed my arm/mediatek branch to my tree at
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> > 
> > Please base the patch on that branch and re-send.
> > 
> 
> I think it is better let Mediatek SoC maintainer Matthias to accept dtsi
> patch like other drivers. This can avoid dtsi conflict. As I
> remember,last time MT8173 IOMMU dtsi patch accepted in iommu tree and
> mt8173.dtsi had conflict with arm soc tree at the merge window. Honghui
> should resend this patch to Matthias, and elaborate your dependency with
> clock and power domain dtsi, then Matthias know the merge sequence. 
> 

Thanks, Eddie.

Hi, Joerg, 
This one is based on CCF "arm: dts: mt2701: Add clock controller device
nodes"[1] and power domain patch "Mediatek MT2701 SCPSYS power domain
support v7"[2],
But these two patchset are still being review now.

Do you think it's better that I send this one later after ccf and power
domain patch got merged, and let Matthias take it?


Thanks.
[1] https://patchwork.kernel.org/patch/9109081
[2]
http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005429.html

> Eddie
> Thanks 
> 
> 

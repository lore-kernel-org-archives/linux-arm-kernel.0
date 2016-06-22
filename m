From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Wed, 22 Jun 2016 16:39:01 +0800
Subject: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
 mt2701
In-Reply-To: <20160622083117.GG11432@8bytes.org>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
 <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
 <20160621095748.GE28248@8bytes.org> <1466574342.27791.8.camel@mtksdaap41>
 <1466581547.8787.18.camel@mtksdaap41> <20160622083117.GG11432@8bytes.org>
Message-ID: <1466584741.8787.22.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-06-22 at 10:31 +0200, Joerg Roedel wrote:
> On Wed, Jun 22, 2016 at 03:45:47PM +0800, Honghui Zhang wrote:
> > This one is based on CCF "arm: dts: mt2701: Add clock controller device
> > nodes"[1] and power domain patch "Mediatek MT2701 SCPSYS power domain
> > support v7"[2],
> > But these two patchset are still being review now.
> > 
> > Do you think it's better that I send this one later after ccf and power
> > domain patch got merged, and let Matthias take it?
> 
> Sure, but the patches I already merged can stay in the tree for now?
> 
> 

I think that driver and dtsi could merged separately, I would prefer
those previous patches stay in the tree if it's OK for you.

Thanks.
> 
> 	Joerg
> 

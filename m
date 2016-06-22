From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 22 Jun 2016 10:31:17 +0200
Subject: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
 mt2701
In-Reply-To: <1466581547.8787.18.camel@mtksdaap41>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
 <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
 <20160621095748.GE28248@8bytes.org>
 <1466574342.27791.8.camel@mtksdaap41>
 <1466581547.8787.18.camel@mtksdaap41>
Message-ID: <20160622083117.GG11432@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 03:45:47PM +0800, Honghui Zhang wrote:
> This one is based on CCF "arm: dts: mt2701: Add clock controller device
> nodes"[1] and power domain patch "Mediatek MT2701 SCPSYS power domain
> support v7"[2],
> But these two patchset are still being review now.
> 
> Do you think it's better that I send this one later after ccf and power
> domain patch got merged, and let Matthias take it?

Sure, but the patches I already merged can stay in the tree for now?



	Joerg

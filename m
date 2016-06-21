From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 21 Jun 2016 11:41:16 +0200
Subject: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
 mt2701
In-Reply-To: <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
 <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20160621094116.GD28248@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 05:51:01PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Add the dtsi node of iommu and smi for mt2701.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  arch/arm/boot/dts/mt2701.dtsi | 51 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Applied the series, except this last patch. It didn't apply cleanly and
I was not sure how to correctly fix that. Can you please resubmit the
patch based on my arm/mediatek branch once I pushed it?

Thanks,

	Joerg

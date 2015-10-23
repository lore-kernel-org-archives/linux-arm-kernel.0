From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 23 Oct 2015 11:26:37 +0200
Subject: [PATCH v5 0/6] MT8173 IOMMU SUPPORT
In-Reply-To: <1445488802.27202.67.camel@mhfsdcap03>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
 <20151014125620.GQ27420@8bytes.org>
 <1445488802.27202.67.camel@mhfsdcap03>
Message-ID: <20151023092636.GX27420@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 12:40:02PM +0800, Yong Wu wrote:
>      But the mtk-iommu depend on the drivers/memory/mtk-smi.c(mtk-iommu
> has called a function of the mtk-smi).
>      So if there is dependence here, How should we do to merge them?

I can surely merge mtk-smi too, if it gets proper Reviewed-by and
Acked-by tags from the maintainer(s).


	Joerg

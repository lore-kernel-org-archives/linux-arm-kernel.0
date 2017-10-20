From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 20 Oct 2017 18:12:54 +0800
Subject: [PATCH v2 0/8] MT2712 IOMMU SUPPORT
In-Reply-To: <20170822143836.ac3faa7wcwfjtvjc@8bytes.org>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
 <20170822143836.ac3faa7wcwfjtvjc@8bytes.org>
Message-ID: <1508494374.15871.6.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-08-22 at 22:38 +0800, Joerg Roedel wrote:
> On Mon, Aug 21, 2017 at 07:00:13PM +0800, Yong Wu wrote:
> > Yong Wu (8):
> >   dt-bindings: mediatek: Add binding for mt2712 IOMMU and SMI
> >   iommu/mediatek: Move MTK_M4U_TO_LARB/PORT into mtk_iommu.c
> >   iommu/mediatek: Add mt2712 IOMMU support
> >   iommu/mediatek: Merge 2 M4U HWs into one iommu domain
> >   iommu/mediatek: Move pgtable allocation into domain_alloc
> >   iommu/mediatek: Disable iommu clock when system suspend
> >   iommu/mediatek: Enlarge the validate PA range for 4GB mode
> >   memory: mtk-smi: Degrade SMI init to module_init
> 
> Applied patches 2-7. Patch 1 is something for Matthias.

gentle ping.

Hi Matthias,

    Could you help review the binding patch[1/8]? if it's ok for you
too, Could you help apply it through your branch with Rob's ACK.
Thanks.

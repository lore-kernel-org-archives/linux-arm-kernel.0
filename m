From: yao.yuan@freescale.com (Yao Yuan)
Date: Fri, 30 Jan 2015 09:00:28 +0000
Subject: [PATCH 1/2] dmaengine: fsl-edma: add dma memcpy support
In-Reply-To: <BN3PR0301MB12364CA46991F6616348AD9087410@BN3PR0301MB1236.namprd03.prod.outlook.com>
References: <1419928907-18053-1-git-send-email-jingchang.lu@freescale.com>
 <1419928907-18053-2-git-send-email-jingchang.lu@freescale.com>
 <BN3PR0301MB12364CA46991F6616348AD9087410@BN3PR0301MB1236.namprd03.prod.outlook.com>
Message-ID: <BL2PR03MB338511438EF5AA594C0B7A883310@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Could you please take some times help to review the two patches?

Thanks.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> On Behalf Of Jingchang Lu
> Sent: Wednesday, January 14, 2015 5:37 PM
> To: Lu Jingchang-B35083; vinod.koul at intel.com
> Cc: dmaengine at vger.kernel.org; dan.j.williams at intel.com; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 1/2] dmaengine: fsl-edma: add dma memcpy support
> 
> Hi, Vinod,
> 
>    Could you please help review the two patches, and merge them if possible?
> Thanks!
> 
> 
> Best Regards,
> Jingchang
> 
> >-----Original Message-----
> >From: Jingchang Lu [mailto:jingchang.lu at freescale.com]
> >Sent: Tuesday, December 30, 2014 4:42 PM
> >To: vinod.koul at intel.com
> >Cc: dan.j.williams at intel.com; dmaengine at vger.kernel.org; linux-
> >kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Lu
> >Jingchang-B35083
> >Subject: [PATCH 1/2] dmaengine: fsl-edma: add dma memcpy support
> >
> >This adds the memory copy capability support, the memcpy functionality
> >needs to configure the DMAMUX of the channel with the always on slave id.
> >
> >Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> >---
> > drivers/dma/fsl-edma.c | 63
> >++++++++++++++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 61 insertions(+), 2 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 14 Jan 2015 09:36:52 +0000
Subject: [PATCH 1/2] dmaengine: fsl-edma: add dma memcpy support
In-Reply-To: <1419928907-18053-2-git-send-email-jingchang.lu@freescale.com>
References: <1419928907-18053-1-git-send-email-jingchang.lu@freescale.com>
 <1419928907-18053-2-git-send-email-jingchang.lu@freescale.com>
Message-ID: <BN3PR0301MB12364CA46991F6616348AD9087410@BN3PR0301MB1236.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Vinod,

   Could you please help review the two patches, and merge them if possible? Thanks!


Best Regards,
Jingchang

>-----Original Message-----
>From: Jingchang Lu [mailto:jingchang.lu at freescale.com]
>Sent: Tuesday, December 30, 2014 4:42 PM
>To: vinod.koul at intel.com
>Cc: dan.j.williams at intel.com; dmaengine at vger.kernel.org; linux-
>kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Lu
>Jingchang-B35083
>Subject: [PATCH 1/2] dmaengine: fsl-edma: add dma memcpy support
>
>This adds the memory copy capability support, the memcpy functionality
>needs to configure the DMAMUX of the channel with the always on slave id.
>
>Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>---
> drivers/dma/fsl-edma.c | 63
>++++++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 61 insertions(+), 2 deletions(-)

From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Fri, 4 Nov 2016 03:52:16 +0000
Subject: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
 caching of bypass entries
In-Reply-To: <VI1PR0401MB263890564BC836B7BBE744018DA30@VI1PR0401MB2638.eurprd04.prod.outlook.com>
References: <1478219244-7815-1-git-send-email-nipun.gupta@nxp.com>
 <VI1PR0401MB263890564BC836B7BBE744018DA30@VI1PR0401MB2638.eurprd04.prod.outlook.com>
Message-ID: <DB6PR0402MB269406338DF2031277884F44E6A20@DB6PR0402MB2694.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Stuart Yoder
> Sent: Friday, November 04, 2016 2:27
> To: Nipun Gupta <nipun.gupta@nxp.com>; robin.murphy at arm.com;
> will.deacon at arm.com; linux-arm-kernel at lists.infradead.org;
> iommu at lists.linux-foundation.org
> Cc: Nipun Gupta <nipun.gupta@nxp.com>
> Subject: RE: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
> caching of bypass entries
> 
> 
> 
> > -----Original Message-----
> > From: Nipun Gupta [mailto:nipun.gupta at nxp.com]
> > Sent: Thursday, November 03, 2016 7:27 PM
> > To: robin.murphy at arm.com; will.deacon at arm.com;
> > linux-arm-kernel at lists.infradead.org; iommu at lists.linux-
> > foundation.org
> > Cc: Stuart Yoder <stuart.yoder@nxp.com>; Nipun Gupta
> > <nipun.gupta@nxp.com>
> > Subject: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
> > caching of bypass entries
> 
> When you respin a patch, put the version number in the patch subject:
> 
>    [PATCH v2] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable caching
> of bypass entries

I added that first, but in the last moment used git format-patch after minor updates
and somehow missed it in the final patch :/. Re-spinning v3 with correct version number.

Thanks,
Nipun

> 
> Stuart

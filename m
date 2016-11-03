From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Thu, 3 Nov 2016 20:57:26 +0000
Subject: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable
 caching of bypass entries
In-Reply-To: <1478219244-7815-1-git-send-email-nipun.gupta@nxp.com>
References: <1478219244-7815-1-git-send-email-nipun.gupta@nxp.com>
Message-ID: <VI1PR0401MB263890564BC836B7BBE744018DA30@VI1PR0401MB2638.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Nipun Gupta [mailto:nipun.gupta at nxp.com]
> Sent: Thursday, November 03, 2016 7:27 PM
> To: robin.murphy at arm.com; will.deacon at arm.com; linux-arm-kernel at lists.infradead.org; iommu at lists.linux-
> foundation.org
> Cc: Stuart Yoder <stuart.yoder@nxp.com>; Nipun Gupta <nipun.gupta@nxp.com>
> Subject: [PATCH] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable caching of bypass entries

When you respin a patch, put the version number in the patch subject:

   [PATCH v2] iommu: arm-smmu: Set SMTNMB_TLBEN in ACR to enable caching of bypass entries

Stuart

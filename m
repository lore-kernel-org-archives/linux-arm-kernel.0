From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 14 Feb 2018 15:12:54 +0100
Subject: [PATCH v13 0/2] iommu/smmu-v3: Workaround for hisilicon
 161010801 erratum(reserve HW MSI)
In-Reply-To: <20180213152051.10296-1-shameerali.kolothum.thodi@huawei.com>
References: <20180213152051.10296-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20180214141254.GJ16484@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 03:20:49PM +0000, Shameer Kolothum wrote:
> Shameerali Kolothum Thodi (2):
>   ACPI/IORT: Add msi address regions reservation helper
>   iommu/dma: Add HW MSI(GICv3 ITS) address regions reservation

Okay, the patches look good to me. I plan to queue them into the IOMMU
tree for v4.17. If anyone has objections, please speak up now.


	Joerg

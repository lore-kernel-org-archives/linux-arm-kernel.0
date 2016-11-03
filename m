From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 3 Nov 2016 20:57:03 +0100
Subject: [PATCH v2] iommu/arm-smmu: Don't inadvertently reject multiple
 SMMUv3s
In-Reply-To: <22ac6cba7386e133a97af729526f4e6457745554.1478194747.git.robin.murphy@arm.com>
References: <22ac6cba7386e133a97af729526f4e6457745554.1478194747.git.robin.murphy@arm.com>
Message-ID: <20161103195703.GU3541@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 05:39:07PM +0000, Robin Murphy wrote:
>  drivers/iommu/arm-smmu-v3.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

This looks better, thanks. Cherry-picked the other fix from the
pull-request and applied this on-top.


	Joerg

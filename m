From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 10 May 2016 11:45:53 +0200
Subject: [PATCH v2] iommu/arm-smmu: Use per-domain page sizes.
In-Reply-To: <112fc0e5f9bbe08007778b8438b35025d8e876a4.1462810410.git.robin.murphy@arm.com>
References: <ea520b8c72b5a72a1731bd35f6e3e50872fe6764.1460048991.git.robin.murphy@arm.com>
 <cover.1460048991.git.robin.murphy@arm.com>
 <112fc0e5f9bbe08007778b8438b35025d8e876a4.1462810410.git.robin.murphy@arm.com>
Message-ID: <20160510094553.GG13971@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 05:20:09PM +0100, Robin Murphy wrote:
> Changes from v1: Rebased onto iommu/core to accommodate SMMUv2 changes.
> 
>  drivers/iommu/arm-smmu-v3.c | 19 ++++++++++---------
>  drivers/iommu/arm-smmu.c    | 27 +++++++++++++++------------
>  2 files changed, 25 insertions(+), 21 deletions(-)

Applied, thanks.

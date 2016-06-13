From: jroedel@suse.de (Joerg Roedel)
Date: Mon, 13 Jun 2016 11:01:44 +0200
Subject: [PATCH] iommu/arm-smmu: wire up map_sg for arm-smmu-v3
In-Reply-To: <1464951030-14044-1-git-send-email-will.deacon@arm.com>
References: <1464951030-14044-1-git-send-email-will.deacon@arm.com>
Message-ID: <20160613090144.GB29948@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 11:50:30AM +0100, Will Deacon wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> The map_sg callback is missing from arm_smmu_ops, but is required by
> iommu.h. Similarly to most other IOMMU drivers, connect it to
> default_iommu_map_sg.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Joerg -- this is the only fix I have queued, so could you pick it up
> directly, please?

Queued, thanks Will.

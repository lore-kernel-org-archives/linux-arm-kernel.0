From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 29 May 2015 11:15:13 +0200
Subject: [PATCH 2/2] iommu/arm-smmu: Make force_stage module param
 read-only in sysfs
In-Reply-To: <1432742975-24801-2-git-send-email-will.deacon@arm.com>
References: <1432742975-24801-1-git-send-email-will.deacon@arm.com>
 <1432742975-24801-2-git-send-email-will.deacon@arm.com>
Message-ID: <20150529091513.GG13130@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 05:09:35PM +0100, Will Deacon wrote:
> Changing force_stage dynamically isn't supported by the driver and it
> also doesn't make a whole lot of sense to change it once the SMMU is up
> and running.
> 
> This patch makes the sysfs entry for the parameter read-only.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied both patches, thanks.

From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 17 Jan 2018 14:41:46 +0100
Subject: [PATCH v2 2/3] iommu/ipmmu-vmsa: Remove redundant
 of_iommu_init_fn hook
In-Reply-To: <12163854e04da92b5de586912bf7257fc0fed79a.1515512134.git.robin.murphy@arm.com>
References: <da664cf8f60c77cbb657cc2e3849560604eaf6da.1515512134.git.robin.murphy@arm.com>
 <12163854e04da92b5de586912bf7257fc0fed79a.1515512134.git.robin.murphy@arm.com>
Message-ID: <20180117134146.fcf2dammcuoowiks@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 04:17:26PM +0000, Robin Murphy wrote:
> Having of_iommu_init() call ipmmu_init() via ipmmu_vmsa_iommu_of_setup()
> does nothing that the subsys_initcall wouldn't do slightly later anyway,
> since probe-deferral of masters means it is no longer critical to
> register the driver super-early. Clean it up.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Applied this one, thanks.

The other two are already applied now from your first post.

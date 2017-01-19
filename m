From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2017 16:18:26 +0000
Subject: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing
 workarounds
In-Reply-To: <1484838356-24962-9-git-send-email-sricharan@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
 <1484838356-24962-9-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170119161826.GI31594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 08:35:52PM +0530, Sricharan R wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Now that the appropriate ordering is enforced via profe-deferral of
> masters in core code, rip it all out and bask in the simplicity.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [Sricharan: Rebased on top of ACPI IORT SMMU series]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  * No change
> 
>  drivers/iommu/arm-smmu-v3.c | 46 ++---------------------------------
>  drivers/iommu/arm-smmu.c    | 58 +++++++--------------------------------------
>  2 files changed, 10 insertions(+), 94 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

I can't wait to see this series merged. What's the plan for that?

Will

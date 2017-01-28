From: helgaas@kernel.org (Bjorn Helgaas)
Date: Sat, 28 Jan 2017 15:07:09 -0600
Subject: [PATCH V7 10/11] iommu/arm-smmu: Clean up early-probing
 workarounds
In-Reply-To: <1485188293-20263-11-git-send-email-sricharan@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-11-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170128210709.GG20550@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 09:48:12PM +0530, Sricharan R wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Now that the appropriate ordering is enforced via profe-deferral of

s/profe-deferral/probe-deferral/

> masters in core code, rip it all out and bask in the simplicity.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [Sricharan: Rebased on top of ACPI IORT SMMU series]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 46 ++---------------------------------
>  drivers/iommu/arm-smmu.c    | 58 +++++++--------------------------------------
>  2 files changed, 10 insertions(+), 94 deletions(-)

Yay!

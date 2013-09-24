From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Sep 2013 16:19:46 +0100
Subject: [PATCH 1/7] iommu/arm-smmu: Switch to arch_initcall for driver
 registration
In-Reply-To: <20130924151430.GT4845@alberich>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-2-git-send-email-andreas.herrmann@calxeda.com>
 <20130924151430.GT4845@alberich>
Message-ID: <20130924151946.GA20774@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 04:14:30PM +0100, Andreas Herrmann wrote:
> iommu/arm-smmu: Remove bogus semicolon from if conditions
> 
> Those prevented proper registration of arm_smmu_ops.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  drivers/iommu/arm-smmu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Will,
> 
> It seems that I've managed to exclude the very first patch of the
> series. Here it is.

No worries; I already have a fix for this and Joerg pulled it today.

Will

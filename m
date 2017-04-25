From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 25 Apr 2017 14:26:51 +0200
Subject: [PATCH] iommu: arm-smmu: correct sid to mask
In-Reply-To: <20170424155453.GP12323@arm.com>
References: <1492765416-30835-1-git-send-email-peng.fan@nxp.com>
 <20170424155453.GP12323@arm.com>
Message-ID: <20170425122651.GI7266@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 04:54:54PM +0100, Will Deacon wrote:
> On Fri, Apr 21, 2017 at 05:03:36PM +0800, Peng Fan wrote:
> > -				sid, smmu->smr_mask_mask);
> > +				mask, smmu->smr_mask_mask);
> >  			goto out_free;
> 
> Looks like a copy-paste error to me:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Joerg: do you mind picking this one up, please?

Applied, thanks.

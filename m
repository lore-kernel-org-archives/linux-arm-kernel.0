From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 27 Nov 2018 09:39:12 -0500
Subject: [PATCH 0/9] iommu: clean up/remove modular stuff from non-modules.
In-Reply-To: <20181127101156.GA12298@8bytes.org>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <20181127101156.GA12298@8bytes.org>
Message-ID: <20181127143912.GF14659@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 0/9] iommu: clean up/remove modular stuff from non-modules.] On 27/11/2018 (Tue 11:11) Joerg Roedel wrote:

> Hi Paul,
> 
> thanks for your cleanup!
> 
> The iommu-tree uses another rule for the subject line of patches. Can
> you please resend with correct subject lines? See below for what is
> used.

Sure - I'll wait another day or two in case anyone on the Cc sends in
some additional Acks.

Thanks,
Paul.
--

> 
> The general format is:
> 
> 	iommu/<driver>: _C_apital letter starting subject
> 
> Please also collect the Acks you get and add them to the patches before
> the resend.
> 
> On Mon, Nov 26, 2018 at 05:31:29PM -0500, Paul Gortmaker wrote:
> > Paul Gortmaker (9):
> >   iommu: audit and remove any unnecessary uses of module.h
> Fine.
> >   iommu: rockchip: make it explicitly non-modular
> 	iommu/rockchip: Make it explicitly non-modular
> >   iommu: msm_iommu: make it explicitly non-modular
> 	iommu/msm: Make it explicitly non-modular
> >   iommu: mtk_iommu: make it explicitly non-modular
> 	iommu/mediatek: Make it explicitly non-modular
> >   iommu: ipmmu-vmsa: make it explicitly non-modular
> 	iommu/ipmmu-vmsa: Make it explicitly non-modular
> >   iommu: qcom_iommu: make it explicitly non-modular
> 	iommu/qcom: Make it explicitly non-modular
> >   iommu: tegra-gart: make it explicitly non-modular
> 	iommu/tegra: Make it explicitly non-modular
> >   iommu: arm-smmu: make it explicitly non-modular
> 	iommu/arm-smmu: Make arm-smmu explicitly non-modular
> >   iommu: arm-smmu-v3: make it explicitly non-modular
> 	iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular
> 
> Thanks a lot,
> 
>        Joerg

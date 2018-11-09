From: vkoul@kernel.org (Vinod Koul)
Date: Fri, 9 Nov 2018 12:06:21 +0530
Subject: [PATCH 2/2] arm64: defconfig: Enable some qcom remoteproc configs
In-Reply-To: <20181109062727.GB10915@tuxbook-pro>
References: <20181109061631.8245-1-vkoul@kernel.org>
 <20181109061631.8245-2-vkoul@kernel.org>
 <20181109062727.GB10915@tuxbook-pro>
Message-ID: <20181109063621.GM12092@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-11-18, 22:27, Bjorn Andersson wrote:
> On Thu 08 Nov 22:16 PST 2018, Vinod Koul wrote:
> 
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Enable remoteproc configs to boot the remoteprocs on QC chipsets. These
> > are common configs and not specific to a specific SoC so should be enabled
> > across the board.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/configs/defconfig | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index b02da2e7a39a..b38d92c96c81 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -614,9 +614,15 @@ CONFIG_TEGRA_IOMMU_SMMU=y
> >  CONFIG_ARM_SMMU=y
> >  CONFIG_ARM_SMMU_V3=y
> >  CONFIG_QCOM_IOMMU=y
> > +CONFIG_REMOTEPROC=m
> > +CONFIG_QCOM_ADSP_PIL=m
> 
> This is now CONFIG_QCOM_Q6V5_PAS
> 
> > +CONFIG_QCOM_Q6V5_PIL=m
> 
> and CONFIG_QCOM_Q6V5_MSS

Sure I will update this

-- 
~Vinod

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 Sep 2013 09:29:22 -0700
Subject: [PATCHv2 2/2] defconfig: msm_defconfig: Enable CONFIG_ARCH_MSM8974
In-Reply-To: <5229D0EF.1030906@codeaurora.org>
References: <1378425890-4225-1-git-send-email-rvaswani@codeaurora.org>
 <1378425890-4225-2-git-send-email-rvaswani@codeaurora.org>
 <5229D0EF.1030906@codeaurora.org>
Message-ID: <20130906162922.GF19754@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06, Christopher Covington wrote:
> Hi Rohit,
> 
> On 09/05/2013 08:04 PM, Rohit Vaswani wrote:
> > This patch enables MSM8974 build support.
> > 
> > Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
> > ---
> >  arch/arm/configs/msm_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
> > index 690b5f9..0ed32e5 100644
> > --- a/arch/arm/configs/msm_defconfig
> > +++ b/arch/arm/configs/msm_defconfig
> > @@ -20,6 +20,7 @@ CONFIG_PARTITION_ADVANCED=y
> >  CONFIG_ARCH_MSM=y
> >  CONFIG_ARCH_MSM8X60=y
> >  CONFIG_ARCH_MSM8960=y
> > +CONFIG_ARCH_MSM8974=y
> >  CONFIG_SMP=y
> >  CONFIG_PREEMPT=y
> >  CONFIG_AEABI=y
> 
> Why not turn it on in the multiplatform defconfig (multi_v7_defconfig)?
> 

MSM is not part of multiplatform yet. We have a few more things
to do before that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

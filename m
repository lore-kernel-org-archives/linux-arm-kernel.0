From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 24 Jul 2015 17:58:20 +0530
Subject: [RFC PATCH 4/4] iommu/arm-smmu: Add support for specifying
 regulators
In-Reply-To: <55AE8CBA.90805@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
 <1437152005-25092-5-git-send-email-sricharan@codeaurora.org>
 <55AE8CBA.90805@codeaurora.org>
Message-ID: <006001d0c60c$3d6d39e0$b847ada0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Stephen Boyd
> Sent: Tuesday, July 21, 2015 11:48 PM
> To: Sricharan R
> Cc: devicetree at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> will.deacon at arm.com; iommu at lists.linux-foundation.org;
> mitchelh at codeaurora.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC PATCH 4/4] iommu/arm-smmu: Add support for specifying
> regulators
> 
> On 07/17/2015 09:53 AM, Sricharan R wrote:
> > From: Mitchel Humpherys <mitchelh@codeaurora.org>
> >
> > This adds the support to turn on the regulators required for SMMUs. It
> > is turned on during the SMMU probe and remains 'on' till the device
> > exists.
> 
> The device always exists. Until the driver is removed perhaps?
> 
  Till the device exists.

> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> 
> We won't be using regulators. We'll be using power domains instead so
> please rewrite this patch accordingly.
> 
 Ok. Thanks for the direction.

Regards,
 Sricharan

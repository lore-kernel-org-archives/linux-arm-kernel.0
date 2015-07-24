From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 24 Jul 2015 17:56:10 +0530
Subject: [RFC PATCH 3/4] iommu/arm-smmu: Add support for specifying clocks
In-Reply-To: <20150721150122.GH31095@arm.com>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
 <1437152005-25092-4-git-send-email-sricharan@codeaurora.org>
 <20150721150122.GH31095@arm.com>
Message-ID: <005e01d0c60b$f1f130c0$d5d39240$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> -----Original Message-----
> From: linux-arm-msm-owner at vger.kernel.org [mailto:linux-arm-msm-
> owner at vger.kernel.org] On Behalf Of Will Deacon
> Sent: Tuesday, July 21, 2015 8:31 PM
> To: Sricharan R
> Cc: linux-arm-kernel at lists.infradead.org;
iommu at lists.linux-foundation.org;
> devicetree at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> mitchelh at codeaurora.org
> Subject: Re: [RFC PATCH 3/4] iommu/arm-smmu: Add support for specifying
> clocks
> 
> On Fri, Jul 17, 2015 at 05:53:24PM +0100, Sricharan R wrote:
> > From: Mitchel Humpherys <mitchelh@codeaurora.org>
> >
> > On some platforms with tight power constraints it is polite to only
> > leave your clocks on for as long as you absolutely need them.
> > Currently we assume that all clocks necessary for SMMU register access
> > are always on.
> 
> You've borrowed this commit message from Mitch's previous version of this
> patch, but now you leave the clocks enabled most of the time so it doesn't
> make much sense anymore.
> 
 Sorry, I should have changed that to make it clear.

> Anyway, I'm OK with this kind of clock management in the driver, but I
think
> that anything more fine-grained needs to be designed into the IOMMU core.
> 
  Ok. Tried this to get the right direction.
 I will  check for the power savings and if there are not much then I would
use
 the above approach.

Regards,
  Sricharan

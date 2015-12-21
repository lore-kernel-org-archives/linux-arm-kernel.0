From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2015 09:55:01 +0000
Subject: [PATCH v2 1/2] IOMMU: arm-smmu-v3: Fix broken STE.VALID check in
 Broadcom Vulcan
In-Reply-To: <CC0BC9CB4553B146B290EC1D4DC5C35901096047@SJEXCHMB15.corp.ad.broadcom.com>
References: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
 <20151217114216.GB11456@arm.com>
 <CC0BC9CB4553B146B290EC1D4DC5C35901096047@SJEXCHMB15.corp.ad.broadcom.com>
Message-ID: <20151221095500.GB23092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 04:47:30AM +0000, Prem (Premachandra) Mallappa wrote:
> Hi Will, 

Hello Prem,

> > 
> > Is this workaround only needed for bypass STEs? If not, we have a problem
> > when we install a stage-1 entry, because we'll clear the EATS bits as it stands.
> >
> 
> Yes, this _was_ needed only in Bypass STEs, AFAIK.
> However, the h/w fixes that were committed recently has this worked out. 
> I have tested and confirmed this patch is no longer necessary. We'll drop
> this series as STE.VALID is not broken anymore :).

Hey, that's an early Christmas present! :)

Will

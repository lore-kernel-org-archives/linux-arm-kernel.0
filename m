From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Apr 2013 09:59:46 +0100
Subject: [PATCH] documentation: iommu: add description of ARM System MMU
 binding
In-Reply-To: <515F1716.70309@gmail.com>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
 <515EFF1A.5030705@gmail.com>
 <20130405165745.GB17151@mudshark.cambridge.arm.com>
 <515F1716.70309@gmail.com>
Message-ID: <20130408085946.GA17208@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 07:25:26PM +0100, Rob Herring wrote:
> On 04/05/2013 11:57 AM, Will Deacon wrote:
> > Hi Rob,
> > 
> > On Fri, Apr 05, 2013 at 05:43:06PM +0100, Rob Herring wrote:
> 
> [...]
> 
> >>> +- compatible    : Should be one of "arm,smmu-v1" or "arm,smmu-v2"
> >>> +                  depending on the version of the architecture
> >>> +                  implemented.
> >>
> >> We can keep these, but we should have specific models like arm,smmu-400,
> >> etc. as well.
> > 
> > Ok, if distinctions need to be between MMU-400 and a v1 implementation, then
> > we can add those strings later.
> 
> No, you want to have specific values in the dtb's up front. If there is
> something needed later in the kernel, you don't want to require a dtb
> update then. Adding future parts later is fine, but we already know what
> blocks we have.

Yes, you're right. I'll add those for v2.

Cheers,

Will

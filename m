From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 09:48:07 +0100
Subject: [PATCH] iommu/arm-smmu: fix bug in pmd construction
In-Reply-To: <1dbe5bf443a44828bf27d282a93c1065@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1411163922-8833-1-git-send-email-mitchelh@codeaurora.org>
 <1dbe5bf443a44828bf27d282a93c1065@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140922084807.GA25809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 21, 2014 at 08:56:28AM +0100, Varun Sethi wrote:
> I have made changes to the arm smmu driver paging support, as a part of
> the huge page support patch. Will is currently reviewing changes made by
> me. I should be able to post my patch in the next couple of weeks.

Yup, but this patch looks like a sensible change for now. I agree that we
can't currently hit the bug, but that code is intended to be usable for use
across multiple PMDs, so I'll apply this.

Will

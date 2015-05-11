From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 May 2015 11:40:31 +0100
Subject: [RFC PATCH] iommu: add ARM short descriptor page table allocator.
In-Reply-To: <20150511101309.GH20611@8bytes.org>
References: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
 <20150505161802.GA20611@8bytes.org> <20150505170541.GN1550@arm.com>
 <20150511101309.GH20611@8bytes.org>
Message-ID: <20150511104030.GA4795@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 11:13:09AM +0100, Joerg Roedel wrote:
> On Tue, May 05, 2015 at 06:05:41PM +0100, Will Deacon wrote:
> > I think the MT8173 IOMMU [1] uses this format and, since it's part of
> > the ARM architecture, the ARM SMMU can make use of it too if the
> > implementation supports it.
> 
> I think it makes more sense to merge this with a driver actually using
> it. I guess a driver for the above mentioned IOMMU will be submitted
> soon?

I completely agree; since there are already patches floating around for
that IOMMU, it's probably worth them being put into a single series.

Will

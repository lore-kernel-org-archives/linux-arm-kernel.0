From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 11 May 2015 12:13:09 +0200
Subject: [RFC PATCH] iommu: add ARM short descriptor page table allocator.
In-Reply-To: <20150505170541.GN1550@arm.com>
References: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
 <20150505161802.GA20611@8bytes.org> <20150505170541.GN1550@arm.com>
Message-ID: <20150511101309.GH20611@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 06:05:41PM +0100, Will Deacon wrote:
> I think the MT8173 IOMMU [1] uses this format and, since it's part of
> the ARM architecture, the ARM SMMU can make use of it too if the
> implementation supports it.

I think it makes more sense to merge this with a driver actually using
it. I guess a driver for the above mentioned IOMMU will be submitted
soon?


	Joerg

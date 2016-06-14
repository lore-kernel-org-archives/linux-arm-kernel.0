From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Jun 2016 17:01:11 +0100
Subject: [PATCH v3 1/2] arm-smmu: doc: add SMMU mask documentation
In-Reply-To: <1465469001-2352-2-git-send-email-thommyj@gmail.com>
References: <5757FD62.2010403@arm.com>
 <1465469001-2352-1-git-send-email-thommyj@gmail.com>
 <1465469001-2352-2-git-send-email-thommyj@gmail.com>
Message-ID: <20160614160110.GE16531@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 12:43:20PM +0200, Thommy Jakobsson wrote:
> Add documentation on how to use a mask for a StreamId.
> 
> Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

We should *really* be moving people over to the generic IOMMU bindings
rather than extending this one.

Will

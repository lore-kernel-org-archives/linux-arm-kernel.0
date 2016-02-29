From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Feb 2016 16:51:53 +0000
Subject: [PATCH 05/12] arm64/dma-mapping: Remove default domain workaround
In-Reply-To: <698ecf1450da8b56a8f297b83815d2fe866ca0e1.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
 <698ecf1450da8b56a8f297b83815d2fe866ca0e1.1456514380.git.robin.murphy@arm.com>
Message-ID: <20160229165153.GB15650@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 01:46:14PM +0000, Robin Murphy wrote:
> With the IOMMU core now taking care of default domains for groups
> regardless of bus type, we can gleefully rip out this stop-gap, as
> slight recompense for having to expand the other one.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

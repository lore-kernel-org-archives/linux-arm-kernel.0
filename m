From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 7 Apr 2016 15:08:17 +0200
Subject: [PATCH 1/3] iommu: Add MMIO mapping type
In-Reply-To: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy@arm.com>
References: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy@arm.com>
Message-ID: <20160407130817.GD31146@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 12:39:30PM +0100, Robin Murphy wrote:
> On some platforms, MMIO regions might need slightly different treatment
> compared to mapping regular memory; add the notion of MMIO mappings to
> the IOMMU API's memory type flags, so that callers can let the IOMMU
> drivers know to do the right thing.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied the series, thanks.

From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 21 Jun 2016 11:59:44 +0200
Subject: [RFC PATCH 15/15] iommu/exynos: update to use iommu big-endian
In-Reply-To: <20160608183110.13851-16-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-16-matthew@mattleach.net>
Message-ID: <20160621095944.GF28248@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 07:31:10PM +0100, Matthew Leach wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Add initial support for big endian by always writing the pte
> in le32. Note, revisit if hardware capable of doing big endian
> fetches.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: iommu at lists.linux-foundation.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org (open list)
> ---
>  drivers/iommu/exynos-iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

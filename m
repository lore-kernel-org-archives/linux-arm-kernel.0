From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 31 Jul 2014 14:04:24 +0200
Subject: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
References: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140731120424.GK9809@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 12:43:03PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied, thanks everyone.

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 May 2014 12:07:52 +0200
Subject: [PATCH v13 00/19] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <5576160.rCaFbvon4G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 May 2014 11:44:45 Shaik Ameer Basha wrote:
> This is the subset of previous v12 series and includes only the fixes and
> enhancements, leaving out the private DT bindings as discussed in the below thread.
>     -- http://www.gossamer-threads.com/lists/linux/kernel/1918178
> 
> This patch series includes,
> 1] fixes for exynos-iommu driver build break
> 2] includes several bug fixes and enhancements for the exynos-iommu driver
> 3] code to handle multiple exynos sysmmu versions
> 4] adding support for device tree
>         Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt

The patches look good to me, but please add a note into the samsung,sysmmu.txt
file explaining that the binding is incomplete and that it's possible to
change in incompatible ways when we add support for attaching devices to
the IOMMU through the generic IOMMU binding.

	Arnd

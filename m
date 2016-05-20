From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 20 May 2016 16:02:36 +0200
Subject: [PATCH] iommu/exynos: Suppress unbinding to prevent system failure
In-Reply-To: <1463752114-23653-1-git-send-email-m.szyprowski@samsung.com>
References: <1463752114-23653-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <573F18FC.9000506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2016 03:48 PM, Marek Szyprowski wrote:
> Removal of IOMMU driver cannot be done reliably, so Exynos IOMMU driver
> doesn't support this operation. It is essential for system operation, so
> it makes sense to prevent unbinding by disabling bind/unbind sysfs
> feature for SYSMMU controller driver to avoid kernel ops or trashing
> memory caused by such operation.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: stable at vger.kernel.org  # v4.2+
> ---
>  drivers/iommu/exynos-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

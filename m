From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 26 Jul 2017 11:55:39 +0200
Subject: [PATCH] iommu/exynos: Replace non-existing big-endian Kconfig
 option
In-Reply-To: <1500270422-4805-1-git-send-email-krzk@kernel.org>
References: <1500270422-4805-1-git-send-email-krzk@kernel.org>
Message-ID: <20170726095539.GH15833@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 07:47:02AM +0200, Krzysztof Kozlowski wrote:
> Wrong Kconfig option was used when adding warning for untested
> big-endian capabilities. There is no CONFIG_BIG_ENDIAN option.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iommu/exynos-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

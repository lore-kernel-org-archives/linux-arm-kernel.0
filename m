From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 18 Jun 2015 12:58:08 +0900
Subject: [PATCH v2] ARM: dts: Update video-phy node with syscon phandle for
 Exynos3250
In-Reply-To: <1434355966-4566-1-git-send-email-b.michalska@samsung.com>
References: <1434355966-4566-1-git-send-email-b.michalska@samsung.com>
Message-ID: <558241D0.50002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.06.2015 17:12, Beata Michalska wrote:
> As a follow-up to recent changes to Exynos mipi video phy
> driver, introducing support for PMU regmap in commit
> e4b3d38088df6f3acd40 ("phy: exynos-video-mipi: Fix regression
> by adding support for PMU regmap") add a syscon phandle to
> video-phy node to bring back to life both MIPI DSI display
> and MIPI CSIS-2 camera sensor on Exynos3250.
> 
> Signed-off-by: Beata Michalska <b.michalska@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks for the patch, I applied it to my tree. Since it is a fix for
regression, I'll sent it to Kukjin for v4.2-rc cycle, unless he picks it
up from LKML.

Best regards,
Krzysztof

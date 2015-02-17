From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 17 Feb 2015 18:25:22 +0900
Subject: drm/exynos: DRM_EXYNOS7DECON?
In-Reply-To: <1424163888.7082.16.camel@x220>
References: <1424163888.7082.16.camel@x220>
Message-ID: <54E30902.5070000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015? 02? 17? 18:04, Paul Bolle wrote:
> Your commit 96976c3d9aff ("drm/exynos: Add DECON driver") is included in
> today's linux-next (ie, next-20150217). I noticed because a script I use
> to check linux-next spotted a problem with it.
> 
> It added an (optional) dependency on DRM_EXYNOS7DECON instead of
> DRM_EXYNOS7_DECON (see drivers/gpu/drm/exynos/Kconfig). Is the trivial
> patch to correct this typo queued somewhere? (This assumes an optional
> dependency on DRM_EXYNOS7_DECON is actually needed for DRM_EXYNOS_DP, of
> course.)

Ah, right. It's my mistake. That is just typo so it should be
DRM_EXYNOS7_DECON instead of DRM_EXYNOS7DECON. It would be fixed at RC1.

Thanks for report,
Inki Dae

> 
> 
> Paul Bolle
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 17 Feb 2015 10:04:48 +0100
Subject: drm/exynos: DRM_EXYNOS7DECON?
Message-ID: <1424163888.7082.16.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Your commit 96976c3d9aff ("drm/exynos: Add DECON driver") is included in
today's linux-next (ie, next-20150217). I noticed because a script I use
to check linux-next spotted a problem with it.

It added an (optional) dependency on DRM_EXYNOS7DECON instead of
DRM_EXYNOS7_DECON (see drivers/gpu/drm/exynos/Kconfig). Is the trivial
patch to correct this typo queued somewhere? (This assumes an optional
dependency on DRM_EXYNOS7_DECON is actually needed for DRM_EXYNOS_DP, of
course.)


Paul Bolle

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 08 Aug 2015 15:53:10 +0900
Subject: [PATCH 2/4] drm/bridge: Add vendor prefixes
In-Reply-To: <1438964855-16989-2-git-send-email-thierry.reding@gmail.com>
References: <1438964855-16989-1-git-send-email-thierry.reding@gmail.com>
 <1438964855-16989-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <55C5A756.7050308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 08.08.2015 o 01:27, Thierry Reding pisze:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use vendor prefixes for Kconfig symbols and filenames. This should make
> it easier to identify the various bridge drivers and to organize the
> directory.
> 
> While at it, rename dw_hdmi.[ch] to dw-hdmi.[ch] for consistency.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm/configs/exynos_defconfig                    |  4 ++--
>  arch/arm/configs/multi_v7_defconfig                  |  4 ++--
>  drivers/gpu/drm/bridge/Kconfig                       | 10 +++++-----
>  drivers/gpu/drm/bridge/Makefile                      |  6 +++---
>  drivers/gpu/drm/bridge/{dw_hdmi.c => dw-hdmi.c}      |  2 +-
>  drivers/gpu/drm/bridge/{dw_hdmi.h => dw-hdmi.h}      |  0
>  drivers/gpu/drm/bridge/{ptn3460.c => nxp-ptn3460.c}  |  0
>  drivers/gpu/drm/bridge/{ps8622.c => parade-ps8622.c} |  0
>  8 files changed, 13 insertions(+), 13 deletions(-)
>  rename drivers/gpu/drm/bridge/{dw_hdmi.c => dw-hdmi.c} (99%)
>  rename drivers/gpu/drm/bridge/{dw_hdmi.h => dw-hdmi.h} (100%)
>  rename drivers/gpu/drm/bridge/{ptn3460.c => nxp-ptn3460.c} (100%)
>  rename drivers/gpu/drm/bridge/{ps8622.c => parade-ps8622.c} (100%)

I assume this will go through some DRM tree? If yes then:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

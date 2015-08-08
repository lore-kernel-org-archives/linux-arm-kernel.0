From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 08 Aug 2015 15:54:43 +0900
Subject: [PATCH 3/4] drm/panel: Add Samsung prefix to panel drivers
In-Reply-To: <1438964855-16989-3-git-send-email-thierry.reding@gmail.com>
References: <1438964855-16989-1-git-send-email-thierry.reding@gmail.com>
 <1438964855-16989-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <55C5A7B3.2010701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 08.08.2015 o 01:27, Thierry Reding pisze:
> From: Thierry Reding <treding@nvidia.com>
> 
> The likelihood of getting a large number of panel drivers from different
> vendors is quite high. Add a prefix to the two existing Samsung panel
> drivers to set a guideline for future patch submissions. Using vendor
> prefixes consistently should allow a cleaner organization of the tree.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm/configs/exynos_defconfig                                 | 2 +-
>  arch/arm/configs/multi_v7_defconfig                               | 2 +-

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


>  drivers/gpu/drm/panel/Kconfig                                     | 8 ++++----
>  drivers/gpu/drm/panel/Makefile                                    | 4 ++--
>  drivers/gpu/drm/panel/{panel-ld9040.c => panel-samsung-ld9040.c}  | 2 +-
>  .../gpu/drm/panel/{panel-s6e8aa0.c => panel-samsung-s6e8aa0.c}    | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/gpu/drm/panel/{panel-ld9040.c => panel-samsung-ld9040.c} (99%)
>  rename drivers/gpu/drm/panel/{panel-s6e8aa0.c => panel-samsung-s6e8aa0.c} (99%)

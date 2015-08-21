From: jingoohan1@gmail.com (Jingoo Han)
Date: Fri, 21 Aug 2015 17:20:57 +0900
Subject: [PATCH v3 0/14] Add Analogix Core Display Port Driver
In-Reply-To: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
Message-ID: <105A0032-83A0-4B75-AE94-258F12451670@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015. 8. 19., at PM 11:48, Yakir Yang <ykk@rock-chips.com> wrote:
> 
> 

.....

> .../bindings/video/analogix_dp-rockchip.txt        |   83 ++
> .../devicetree/bindings/video/exynos_dp.txt        |   51 +-
> arch/arm/boot/dts/exynos5250-arndale.dts           |   10 +-
> arch/arm/boot/dts/exynos5250-smdk5250.dts          |   10 +-
> arch/arm/boot/dts/exynos5250-snow.dts              |   12 +-
> arch/arm/boot/dts/exynos5250-spring.dts            |   12 +-
> arch/arm/boot/dts/exynos5420-peach-pit.dts         |   12 +-
> arch/arm/boot/dts/exynos5420-smdk5420.dts          |   10 +-
> arch/arm/boot/dts/exynos5800-peach-pi.dts          |   12 +-
> drivers/gpu/drm/bridge/Kconfig                     |    5 +
> drivers/gpu/drm/bridge/Makefile                    |    1 +
> drivers/gpu/drm/bridge/analogix_dp_core.c          | 1382 +++++++++++++++++++
> drivers/gpu/drm/bridge/analogix_dp_core.h          |  286 ++++
> drivers/gpu/drm/bridge/analogix_dp_reg.c           | 1294 ++++++++++++++++++
> .../exynos_dp_reg.h => bridge/analogix_dp_reg.h}   |  270 ++--
> drivers/gpu/drm/exynos/Kconfig                     |    5 +-
> drivers/gpu/drm/exynos/Makefile                    |    2 +-
> drivers/gpu/drm/exynos/analogix_dp-exynos.c        |  347 +++++

Would you change this file name to "exynos_dp.c"?

Best regards,
Jingoo Han

> drivers/gpu/drm/exynos/exynos_dp_core.c            | 1416 --------------------
> drivers/gpu/drm/exynos/exynos_dp_core.h            |  282 ----
> drivers/gpu/drm/exynos/exynos_dp_reg.c             | 1263 -----------------
> drivers/gpu/drm/rockchip/Kconfig                   |    9 +
> drivers/gpu/drm/rockchip/Makefile                  |    1 +
> drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  390 ++++++
> drivers/phy/Kconfig                                |    7 +
> drivers/phy/Makefile                               |    1 +
> drivers/phy/phy-rockchip-dp.c                      |  185 +++
> include/drm/bridge/analogix_dp.h                   |   40 +
> 30 files changed, 4325 insertions(+), 3172 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
> create mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> create mode 100644 Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
> create mode 100644 drivers/gpu/drm/bridge/analogix_dp_core.c
> create mode 100644 drivers/gpu/drm/bridge/analogix_dp_core.h
> create mode 100644 drivers/gpu/drm/bridge/analogix_dp_reg.c
> rename drivers/gpu/drm/{exynos/exynos_dp_reg.h => bridge/analogix_dp_reg.h} (62%)
> create mode 100644 drivers/gpu/drm/exynos/analogix_dp-exynos.c
> delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.c
> delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.h
> delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_reg.c
> create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> create mode 100644 drivers/phy/phy-rockchip-dp.c
> create mode 100644 include/drm/bridge/analogix_dp.h
> 
> -- 
> 1.9.1
> 
> 

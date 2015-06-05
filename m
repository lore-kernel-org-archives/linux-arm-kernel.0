From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 06 Jun 2015 03:04:14 +0900
Subject: [GIT PULL 1/5] Samsung defconfig updates for v4.2
Message-ID: <5571E49E.3050707@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Here is exynos_defconfig updates for v4.2.
Please pull.

Thanks,
Kukjin

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig-2

for you to fetch changes up to f882d3cfe87800000e5fa91160db401bb7a38d28:

  ARM: exynos_defconfig: Enable CONFIG_SENSORS_INA2XX for Odroid-XU3
(2015-06-03 09:31:29 +0900)

----------------------------------------------------------------
exynos_defconfig updates for v4.2

- enable DRM_EXYNOS_DSI and DRM_PANEL_S6E8AA0
  for full X11 display on Trats2 board
- enable SENSORS_PWM_FAN
  to control fan power on Odroid-XU3 board
- enable SENSORS_INA2XX
  for power monitor sensor on Odriod-XU3 board
- do savedefconfig
  to remove useless configs and check its dependencies

----------------------------------------------------------------
Anand Moon (2):
      ARM: exynos_defconfig: Enable CONFIG_SENSORS_PWM_FAN for Odroid-XU3
      ARM: exynos_defconfig: Enable CONFIG_SENSORS_INA2XX for Odroid-XU3

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable display on Trats2 board

Kukjin Kim (1):
      ARM: exynos_defconfig: savedefconfig

 arch/arm/configs/exynos_defconfig | 50
+++++++++++++--------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

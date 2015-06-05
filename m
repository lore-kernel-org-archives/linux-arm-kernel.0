From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 06 Jun 2015 03:04:32 +0900
Subject: [GIT PULL 2/5] Samsung 2nd defconfig for v4.2
Message-ID: <5571E4B0.5090001@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is 2nd defconfig updates for v4.2 but actually just one patch for
Samsung updates for multi_v7_defconfig. Please pull or apply the patch
directly, anyway I'm fine either way.

Note that this is based on arm-soc/next/defconfig to avoid useless merge
conflicts and I've merged previous tags/samsung-defconfig-2.

Thanks,
Kukjin

The following changes since commit 8c56c43021002d5983021481e05fa64ec8f6822e:

  Merge branch 'samsung-defconfig-2nd' into samsung-defconfig-3rd
(2015-06-03 10:12:27 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig-3

for you to fetch changes up to 296e4f2e1e8f269a923d6488bac71e501ddca30e:

  ARM: multi_v7_defconfig: Enable display on Trats2 board (2015-06-03
10:12:50 +0900)

----------------------------------------------------------------
multi_v7_defconfig updates for Samsung stuff

- enable DRM_EXYNOS_DSI and DRM_PANEL_S6E8AA0
  in multi_v7_defconfig to support full X11 display

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: multi_v7_defconfig: Enable display on Trats2 board

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

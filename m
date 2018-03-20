From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Mar 2018 02:17:28 +0100
Subject: [GIT PULL] defconfig changes for Versatile DRM
Message-ID: <CACRpkdZcsFhZYCwe_ub4AEyVYfPRkwxTQ7=E4w3NjUE_8agUbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this augments the RealView and Versatile defconfigs to use
DRM on the Pl111 rather than fbdev.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/armsoc-versatile-drm-defconfig

for you to fetch changes up to 59ff3af3f2672453fc08f379ee62ae3c8cedbfa1:

  ARM: defconfig: Configure Versatile boards to use PL111 DRM
(2018-03-20 02:06:54 +0100)

----------------------------------------------------------------
This augments the RealView and Versatile defconfig to use the PL111
DRM driver rather than the old fbdev driver.

----------------------------------------------------------------
Linus Walleij (4):
      ARM: defconfig: Update RealView defconfig
      ARM: defconfig: Switch RealView boards to use P111 DRM
      ARM: defconfig: Update Versatile defconfig
      ARM: defconfig: Configure Versatile boards to use PL111 DRM

 arch/arm/configs/realview_defconfig  | 21 ++++++++++-----------
 arch/arm/configs/versatile_defconfig | 18 +++++++++++-------
 2 files changed, 21 insertions(+), 18 deletions(-)

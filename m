From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 15 Oct 2014 08:27:20 +0900
Subject: [GIT PULL 2/2] Samsung defconfig updates for v3.18
Message-ID: <543DB158.7030303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-defconfig

for you to fetch changes up to 508423bebcda29eb0ba7c627f895387dad7cdcd6:

   ARM: exynos_defconfig: enable USB gadget support (2014-09-25 18:20:18 
+0900)

----------------------------------------------------------------
Samsung defconfig, actually exynos_defconig updates for v3.18
- enable USB gadget support
- enable Maxim77802 support
- enable Maxim77693 and I2C GPIO drivers
- enable Atmel maXTouch support
- enable SBS battery support
- enable Control Groups support

----------------------------------------------------------------
Javier Martinez Canillas (3):
       ARM: exynos_defconfig: Enable Atmel maXTouch support
       ARM: exynos_defconfig: Enable Control Groups support
       ARM: exynos_defconfig: Enable SBS battery support

Krzysztof Kozlowski (1):
       ARM: exynos_defconfig: Enable Maxim 77693 and I2C GPIO drivers

Sjoerd Simons (1):
       ARM: exynos_defconfig: enable USB gadget support

Vivek Gautam (1):
       ARM: exynos_defconfig: Enable MAX77802

  arch/arm/configs/exynos_defconfig | 10 ++++++++++
  1 file changed, 10 insertions(+)

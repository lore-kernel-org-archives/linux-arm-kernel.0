From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Nov 2018 08:47:38 +0100
Subject: [GIT PULL] Versatile Express defconfig updates
Message-ID: <CACRpkdbGp1-TKn41eBq9JijGsYqY83MLWEbr-BU6yRJV+bsoDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

following the DTS update to fit the PL11x DRM driver, this is
an accompanying defconfig update that switches the versatile
express family to use this driver by default.

The defconfig was a bit out of date so I first update it to the
latest Kconfig structure then apply the DRM config changes
on top in a separate patch. This is a v7 patch set that has
been interated and tested for quite some time.

Again I agreed with Liviu Dudau to send these updates to ARM
SoC.

Please pull it in to ARM SoC for v4.21!

Yours,
Linus Walleij

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/vexpress-defconfig-arm-soc

for you to fetch changes up to 7de642a3815d7fa61df0b7f94257034b10a8bfb2:

  ARM: defconfig: Enable the PL111 DRM driver on vexpress (2018-11-29
08:35:21 +0100)

----------------------------------------------------------------
Versatile Express defconfig updates:
This activates the new PL11x DRM driver with the
Versatile Express family of reference designs.

----------------------------------------------------------------
Linus Walleij (2):
      ARM: defconfig: Update the vexpress defconfig
      ARM: defconfig: Enable the PL111 DRM driver on vexpress

 arch/arm/configs/vexpress_defconfig | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

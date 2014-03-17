From: mporter@linaro.org (Matt Porter)
Date: Mon, 17 Mar 2014 13:55:57 -0400
Subject: [GIT PULL] ARM: mach-bcm: soc updates for 3.15 - part 3
Message-ID: <20140317175557.GA17573@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This request contains just one patch that I missed in the part 2
pull request. Please apply.

-Matt

The following changes since commit 7aa2077b55b530fac878e7c05fc970a778eb3950:

  ARM: restrict BCM_KONA_UART to ARCH_BCM_MOBILE (2014-03-14 11:37:33 -0400)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/armsoc/for-3.15/soc-4

for you to fetch changes up to 72585c8b99c52bb05df63e44f9d22ca89435baad:

  ARM: configs: bcm_defconfig: enable bcm590xx regulator support (2014-03-17 13:35:53 -0400)

----------------------------------------------------------------
ARM: mach-bcm: soc updates for 3.15 - part 3

- enable bcm590xx regulator driver in bcm_defconfig

----------------------------------------------------------------
Matt Porter (1):
      ARM: configs: bcm_defconfig: enable bcm590xx regulator support

 arch/arm/configs/bcm_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

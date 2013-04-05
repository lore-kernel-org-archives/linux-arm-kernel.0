From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  4 Apr 2013 19:28:58 -0600
Subject: [GIT PULL 3/3] ARM: bcm2835: defconfig updates
In-Reply-To: <1365125338-6668-1-git-send-email-swarren@wwwdotorg.org>
References: <1365125338-6668-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365125338-6668-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch (patch) updates bcm2835_defconfig to enable new features that
were added this kernel cycle. Namely, the SPI controller and HW random
number generator.

----------------------------------------------------------------

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.10-defconfig

for you to fetch changes up to d8d6aec6d560fb66a25aad567f0630baee6785a1:

  ARM: bcm2835: defconfig updates

----------------------------------------------------------------

Stephen Warren (1):
      ARM: bcm2835: defconfig updates

 arch/arm/configs/bcm2835_defconfig |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

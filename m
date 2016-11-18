From: eric@anholt.net (Eric Anholt)
Date: Fri, 18 Nov 2016 10:58:34 -0800
Subject: [GIT PULL 3/4] bcm2835-defconfig-next-2016-11-18
In-Reply-To: <20161118185835.14452-1-eric@anholt.net>
References: <20161118185835.14452-1-eric@anholt.net>
Message-ID: <20161118185835.14452-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-defconfig-next-2016-11-18

for you to fetch changes up to bab0cb90550467c71f4e1b73da406a2280c4f418:

  ARM: bcm2835: add thermal driver to default config (2016-11-11 09:00:37 -0800)

----------------------------------------------------------------
This pull request enables the BCM2835 (Raspberry Pi) thermal driver in
the Pi1 defconfig.

----------------------------------------------------------------
Martin Sperl (1):
      ARM: bcm2835: add thermal driver to default config

 arch/arm/configs/bcm2835_defconfig | 2 ++
 1 file changed, 2 insertions(+)

From: eric@anholt.net (Eric Anholt)
Date: Fri, 18 Nov 2016 10:58:35 -0800
Subject: [GIT PULL 4/4] bcm2835-defconfig-64-next-2016-11-18
In-Reply-To: <20161118185835.14452-1-eric@anholt.net>
References: <20161118185835.14452-1-eric@anholt.net>
Message-ID: <20161118185835.14452-4-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-defconfig-64-next-2016-11-18

for you to fetch changes up to ac178e4280e65f4d0d14b13a7bfec3a43ff90e66:

  ARM64: bcm2835: add thermal driver to default config (2016-11-11 09:00:00 -0800)

----------------------------------------------------------------
This pull enables the BCM2837 (Pi 3) thermal driver in the defconfig.

----------------------------------------------------------------
Martin Sperl (1):
      ARM64: bcm2835: add thermal driver to default config

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

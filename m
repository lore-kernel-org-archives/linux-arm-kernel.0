From: eric@anholt.net (Eric Anholt)
Date: Tue, 27 Nov 2018 13:12:58 -0800
Subject: [GIT PULL 1/4] bcm2835-defconfig-next-2018-11-27
Message-ID: <20181127211301.30296-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Hopefully I'm not too late this time around.  Stefan's been doing a
great job maintaining the bcm2835 branches, and was waiting for me to
send the PRs.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-11-27

for you to fetch changes up to 24632d6b78a1929b14f32cab762a0859db7086f2:

  ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver (2018-11-15 19:07:36 +0100)

----------------------------------------------------------------
This pull request enables the V4L2 camera driver on the Pi1 defconfig.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver

 arch/arm/configs/bcm2835_defconfig | 3 +++
 1 file changed, 3 insertions(+)

From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 13 Sep 2018 07:50:33 +0200
Subject: [GIT PULL 3/3] bcm2835-defconfig-next-2018-09-09
In-Reply-To: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
References: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1536817833-3900-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-09-09

for you to fetch changes up to 99fa3b0c6082bff346f7d09f29e5edcc93d40bd3:

  ARM: bcm2835_defconfig: Enable bcm2835-audio (2018-09-02 18:49:33 +0200)

----------------------------------------------------------------
This pull request brings enables the RPi audio driver in the
bcm2835_defconfig.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable bcm2835-audio

 arch/arm/configs/bcm2835_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

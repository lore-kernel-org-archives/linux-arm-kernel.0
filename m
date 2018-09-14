From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 14 Sep 2018 16:59:26 -0700
Subject: [GIT PULL 1/3] Broadcom defconfig changes for 4.20
Message-ID: <20180914235928.20551-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.20/defconfig

for you to fetch changes up to 99fa3b0c6082bff346f7d09f29e5edcc93d40bd3:

  ARM: bcm2835_defconfig: Enable bcm2835-audio (2018-09-02 18:49:33 +0200)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs defconfig changes for
4.20, please pull the following:

- Stefan updates the bcm2835_defconfig file to turn on the bcm2835-audio
  driver.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable bcm2835-audio

 arch/arm/configs/bcm2835_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

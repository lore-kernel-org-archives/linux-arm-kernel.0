From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:00:07 +0930
Subject: [PULL REQUEST] aspeed defconfig changes for 4.7
Message-ID: <1462797007-13900-1-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This adds configurations used for testing Aspeed BMC SoCs, as well as adding
the v5 part to the multi defconfig.

Please pull if it looks okay.

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  https://github.com/shenki/linux.git tags/aspeed-for-4.7-defconfig

for you to fetch changes up to d0bc3483da8774dcea1e0692586830031783f08c:

  arm/configs: Add Aspeed defconfig (2016-05-09 19:12:30 +0930)

----------------------------------------------------------------
aspeed defconfig for 4.7

----------------------------------------------------------------
Joel Stanley (2):
      arm/configs/multi_v5: Add Aspeed ast2400
      arm/configs: Add Aspeed defconfig

 arch/arm/configs/aspeed_g4_defconfig | 86 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/aspeed_g5_defconfig | 88 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v5_defconfig  |  8 +++-
 3 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/configs/aspeed_g4_defconfig
 create mode 100644 arch/arm/configs/aspeed_g5_defconfig

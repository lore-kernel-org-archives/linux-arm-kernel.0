From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 21 May 2013 11:46:13 +0200
Subject: [PATCH 0/3] ARM: ux500: Update defconfigs for MMC
Message-ID: <1369129576-28617-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the MMC defconfigs in the u8500|u300_defconfig.

Ulf Hansson (3):
  ARM: ux500: Enable MMC_UNSAFE_RESUME
  ARM: ux500: Don't use MMC_CLKGATE
  ARM: ux500: Disable MMC_BLOCK_BOUNCE

 arch/arm/configs/u300_defconfig  |    3 ++-
 arch/arm/configs/u8500_defconfig |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.7.10

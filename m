From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 15:15:45 +0100
Subject: [GIT PULL] at91 defconfigs for 3.3
Message-ID: <4EEA0111.2000907@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is a single patch that removes a defconfig for AT91. 
It is not needed anymore as we tend to group defconfigs by
SoC and build all boards into it.

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git for-arnd-3.3-defconfig

Paul Gortmaker (1):
      ARM: at91: delete the pcontrol_g20_defconfig

 arch/arm/configs/pcontrol_g20_defconfig |  175 -------------------------------
 1 files changed, 0 insertions(+), 175 deletions(-)
 delete mode 100644 arch/arm/configs/pcontrol_g20_defconfig

Thanks, best regards,
-- 
Nicolas Ferre

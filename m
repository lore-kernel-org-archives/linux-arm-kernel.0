From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 May 2015 15:54:04 +0200
Subject: [GIT PULL] at91: defconfig for 4.2 #1
Message-ID: <1432043644-25879-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Little update to defconfig files... but big step forward for AT91 as we now
enter the multi_v7_defconfig club!
The pull-request is based on v4.2-rc3.

Thanks, best regards,

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig

for you to fetch changes up to 822cfdfb9511c2658a10a21b0323144c632aa08c:

  ARM: multi_v7_defconfig: Add Atmel SAMA5 family (2015-05-19 15:38:40 +0200)

----------------------------------------------------------------
First batch of defconfig changes for 4.2:
- fixed regulators for sd/mmc
- addition of AT91 to the multi_v7_defconfig

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: multi_v7_defconfig: Add Atmel SAMA5 family

Nicolas Ferre (1):
      ARM: at91/defconfig: add CONFIG_REGULATOR_FIXED_VOLTAGE for mmc driver

 arch/arm/configs/at91_dt_defconfig  |  2 ++
 arch/arm/configs/multi_v7_defconfig | 26 ++++++++++++++++++++++++++
 arch/arm/configs/sama5_defconfig    |  1 +
 3 files changed, 29 insertions(+)

-- 
Nicolas Ferre

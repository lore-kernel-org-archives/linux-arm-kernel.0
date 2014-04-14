From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Apr 2014 11:15:43 +0200
Subject: [GIT PULL] Ux500/U300 defconfig updates for v3.15-rc:s
Message-ID: <CACRpkdb+hnZvNgEfjWBhao=MU5Hx0GLXEqxXnu4ifk1AUZFD1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a set of defconfig updates for the Ux500 and one update for
the U300. It activates compilation of some features available
upstream that applies to these platform.

Please pull it in for the early -rc cycle!

Yours,
Linus Walleij


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson
tags/ux500-defconfig-for-arm-soc

for you to fetch changes up to 1fb4e407b520a2344b92a680c75672c7900aedf8:

  ARM: ux500: configure for CW1200 WLAN chip (2014-04-14 11:08:26 +0200)

----------------------------------------------------------------
This is a patch set for some ST-Ericsson devices:
- Updates the Ux500 (U8500) defconfig
- Selects PARTITION_ADVANCED for Ux500 and U300
- Configure in IIO sensor drivers for the Ux500
- Configure in the CW1200 WLAN chip for the Ux500

----------------------------------------------------------------
Linus Walleij (3):
      ARM: ux500: update defconfig
      ARM: ux500: configure in sensors
      ARM: ux500: configure for CW1200 WLAN chip

Ulf Hansson (2):
      ARM: ux500: u8500_defconfig: Enable PARTITION_ADVANCED
      ARM: u300: u300_defconfig: Enable PARTITION_ADVANCED

 arch/arm/configs/u300_defconfig  |  4 ++--
 arch/arm/configs/u8500_defconfig | 24 +++++++++++++++---------
 2 files changed, 17 insertions(+), 11 deletions(-)

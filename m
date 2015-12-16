From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Dec 2015 11:20:26 +0100
Subject: [GIT PULL] at91: defconfig for 4.5 #1
Message-ID: <1450261226-2102-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

As single patch for this pull-request: tell me if you would like to take it
independently, as a patch.

Thanks, best regards,

The following changes since commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8:

  Linux 4.4-rc3 (2015-11-29 18:58:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig

for you to fetch changes up to 94c2317cf46a9c137650bf30f2aba7271886c0b4:

  ARM: at91/defconfig: enable watchdog drivers in sama5_defconfig (2015-12-15 11:18:39 +0100)

----------------------------------------------------------------
First defconfig pull-request for 4.5:
- a single patch to add watchdog drivers to sama5_defconfig

----------------------------------------------------------------
Wenyou Yang (1):
      ARM: at91/defconfig: enable watchdog drivers in sama5_defconfig

 arch/arm/configs/sama5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
Nicolas Ferre

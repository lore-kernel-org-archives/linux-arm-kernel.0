From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 19 Oct 2015 22:26:08 +0200
Subject: [GIT PULL] at91: defconfig for 4.4 #1
Message-ID: <20151019202608.GA32225@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A defconfig update, adding sama5d2 peripherals to sama5_defconfig and
multi_v7_defconfig

Thanks,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-defconfig

for you to fetch changes up to 4af8540f0082812e2e092f2d31dbb4d114eee968:

  ARM: multi_v7_defconfig: Add Atmel SDHCI device (2015-10-19 21:52:21 +0200)

----------------------------------------------------------------
defconfig update for 4.4:
- Add sama5d2 and its peripherals to sama5_defconfig and multi_v7_defconfig
- Trivial savedefconfig updates to at91_dt_defconfig and sama5_defconfig

----------------------------------------------------------------
Ludovic Desroches (6):
      ARM: at91/defconfig: update sama5 defconfig
      ARM: at91/defconfig: update at91_dt defconfig
      ARM: at91/defconfig: add sama5d2 and its new devices to sama5 defconfig
      ARM: multi_v7_defconfig: Add Atmel SAMA5D2 SoC
      ARM: multi_v7_defconfig: Add Atmel Flexcom device
      ARM: multi_v7_defconfig: Add Atmel SDHCI device

 arch/arm/configs/at91_dt_defconfig  | 15 ---------------
 arch/arm/configs/multi_v7_defconfig |  3 +++
 arch/arm/configs/sama5_defconfig    | 16 ++++++----------
 3 files changed, 9 insertions(+), 25 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 2 Dec 2014 17:28:31 +0100
Subject: [GIT PULL] at91: defconfig for 3.19 #1
Message-ID: <1417537711-15608-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here is a pull-request for updating the AT91 defconfig files. Note that we only
have two now that the per-SoC defconfigs are gone.

Thanks, best regards,

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig

for you to fetch changes up to 4cd275f762a21cf21768e327873ba2883c839281:

  ARM: at91/defconfig: add DM9000 to at91_dt (2014-12-01 16:30:00 +0100)

----------------------------------------------------------------
First batch of defconfigs for AT91 / 3.19:
- use NEON for all C-A5, neon code handles the !NEON case
- add new XDMA driver
- add some useful drivers as we only have a single defconfig for all
  AT91SAM9/RM9200

----------------------------------------------------------------
Ludovic Desroches (1):
      ARM: at91: sama5: update defconfig

Nicolas Ferre (4):
      ARM: at91/defconfig: add the XDMA driver
      ARM: at91/defconfig: add TCB PWM driver selection
      ARM: at91/defconfig: add QT1070 to at91_dt
      ARM: at91/defconfig: add DM9000 to at91_dt

 arch/arm/configs/at91_dt_defconfig | 3 +++
 arch/arm/configs/sama5_defconfig   | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
Nicolas Ferre

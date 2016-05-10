From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 May 2016 14:20:42 +0200
Subject: [GIT PULL] at91: defconfig for 4.7 #2
Message-ID: <1462882842-23968-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A couple of defconfig updates for AT91. They both touch our own
sama5_defconfig only.

Thanks, best regards,

The following changes since commit ed87957b18f238516e578e5dbd44a5db11300831:

  ARM: multi_v7_defconfig: add the Atmel sama5d2-compatible ADC driver (2016-04-27 14:07:59 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig2

for you to fetch changes up to f0d523668cb122905a541cb6b86e3ae49260ae5e:

  ARM: at91/defconfig: sama5: add CONFIG_FHANDLE (2016-05-10 09:57:44 +0200)

----------------------------------------------------------------
Second batch of defconfig:
- sama5_defconfig: update to support easy use of systemd userspace

----------------------------------------------------------------
Marek Vasut (1):
      ARM: at91: sama5: Update defconfig

Nicolas Ferre (1):
      ARM: at91/defconfig: sama5: add CONFIG_FHANDLE

 arch/arm/configs/sama5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
Nicolas Ferre

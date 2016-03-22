From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Mar 2016 17:46:57 +0100
Subject: [GIT PULL] at91: fixes for 4.6 #1
Message-ID: <1458665217-22369-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here is a "-fixes" tag that also can be considered as a "late DT" one for 4.6. I
added the two patches by Ludovic on top of the previous DT material that you
already pushed to Linus (at91-dt2 tag that was built on top of 4.5-rc3).
It merges perfectly well with current Mainline and linux-next.

Thanks, best regards,

The following changes since commit ed0f4b3ffcdbd2b47a0b24035bb6f22464c9fef1:

  ARM: dts: at91: sama5d2 Xplained: add leds node (2016-03-02 16:55:37 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to b02acd4e62602a6ab307da84388a16bf60106c48:

  ARM: dts: at91: sama5d4 Xplained: don't disable hsmci regulator (2016-03-22 11:54:32 +0100)

----------------------------------------------------------------
First fixes batch for AT91 on 4.6 - DT only fixes:
- prevent the boards from having glitches when inserting/removing SD card on
  sama5d3/d4 Xplained. The regulators should be kept on.

----------------------------------------------------------------
Ludovic Desroches (2):
      ARM: dts: at91: sama5d3 Xplained: don't disable hsmci regulator
      ARM: dts: at91: sama5d4 Xplained: don't disable hsmci regulator

 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 1 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 1 +
 2 files changed, 2 insertions(+)

-- 
Nicolas Ferre

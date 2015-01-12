From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 Jan 2015 16:27:52 +0100
Subject: [GIT PULL] at91: fixes for 3.19 #1 (ter)
Message-ID: <1421076472-10589-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here is the fixes pull-request for 3.19 that supersedes the ones already sent.
It collects all the fixes that I have currently for this kernel revision.

Thanks, best regards,

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to b8659752c37ec157ee254cff443b1c9d523aea22:

  ARM: at91: board-dt-sama5: add phy_fixup to override NAND_Tree (2015-01-12 15:50:23 +0100)

----------------------------------------------------------------
First fixes batch for AT91 on 3.19:
- fix some DT entries
- correct clock entry for the at91sam9263 LCD
- add a phy_fixup for Eth1 on sama5d4

----------------------------------------------------------------
Alexander Stein (1):
      ARM: at91/dt: sam9263: Add missing clocks to lcdc node

Bo Shen (2):
      ARM: at91/dt: sama5d4: fix the timer reg length
      ARM: at91: sama5d3: dt: correct the sound route

Wenyou Yang (1):
      ARM: at91: board-dt-sama5: add phy_fixup to override NAND_Tree

 arch/arm/boot/dts/at91sam9263.dtsi  |  2 ++
 arch/arm/boot/dts/sama5d3xmb.dtsi   |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi      |  2 +-
 arch/arm/mach-at91/board-dt-sama5.c | 18 ++++++++++++++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre

From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Jan 2015 18:09:42 +0100
Subject: [GIT PULL] at91: defconfig for 3.20 #1
Message-ID: <1421341782-14355-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A little defconfig update. If you want me to collect more patches before
sending you a more substantial one, let me know.

Thanks, bye,

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-defconfig

for you to fetch changes up to a1b282911b47a522f150eb715fb037628c5173fe:

  ARM: at91: sama5: enable atmel-isi and ov2640 in defconfig (2015-01-15 16:28:23 +0100)

----------------------------------------------------------------
First batch of defconfig update for 3.20:
- we remove DEBUG_LL from sama5 defconfig as all SoC are not compatible
- enable ISI and selected sensors

----------------------------------------------------------------
Josh Wu (1):
      ARM: at91: sama5: enable atmel-isi and ov2640 in defconfig

Maxime Ripard (1):
      ARM: at91/config: sama5: Remove DEBUG_LL

 arch/arm/configs/sama5_defconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
Nicolas Ferre

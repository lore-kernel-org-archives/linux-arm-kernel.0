From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 May 2016 17:12:14 +0200
Subject: [GIT PULL] at91: fixes for 4.6 #2
Message-ID: <1462979534-29347-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another regression reported by Richard yesterday and quickly fixed by Boris.
Since this regression was introduced in 4.6-rc1 it would be great if you could
take it before 4.6 is released.

Thanks, best regards,

The following changes since commit b8453d4ee9e24c6590dd0eecbab1c3cc2028317f:

  ARM: dts: at91: sama5d2: use "atmel,sama5d3-nfc" compatible for nfc (2016-05-10 09:09:47 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes2

for you to fetch changes up to aab0a4c83ceb344d2327194bf354820e50607af6:

  ARM: dts: at91: sam9x5: Fix the memory range assigned to the PMC (2016-05-11 16:31:40 +0200)

----------------------------------------------------------------
Second AT91 fix PR for 4.6:
- fix a regression on the clock subsystem while switching to syscon/regmap
  due to a stricter check of the register map.

----------------------------------------------------------------
Boris Brezillon (1):
      ARM: dts: at91: sam9x5: Fix the memory range assigned to the PMC

 arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Nicolas Ferre

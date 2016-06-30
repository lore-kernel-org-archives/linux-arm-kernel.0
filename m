From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 30 Jun 2016 16:14:58 +0300
Subject: [PATCH 0/5] ARM: OMAP2+: hwmod/clk related fixes
Message-ID: <1467292503-4376-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches have been split out of the series here:

http://www.spinics.net/lists/arm-kernel/msg510985.html

Basically a few fixes to the hwmod / clk related functionality
under mach-omap2.

This split up series has been boot tested on following platforms:

  : Board           : Boot WRN version                 
 1: am335x-evm      : PASS   0 4.7.0-rc1-00005-g8238af6
 2: am335x-evmsk    : PASS   0 4.7.0-rc1-00005-g8238af6
 3: am3517-evm      : PASS   1 4.7.0-rc1-00005-g8238af6
 4: am37x-evm       : PASS   0 4.7.0-rc1-00005-g8238af6
 5: am437x-sk       : PASS   0 4.7.0-rc1-00005-g8238af6
 6: am43x-epos-evm  : PASS   0 4.7.0-rc1-00005-g8238af6
 7: am437x-gp-evm   : PASS   0 4.7.0-rc1-00005-g8238af6
 8: am57xx-evm      : PASS   3 4.7.0-rc1-00005-g8238af6
 9: omap3-beagle-xm : PASS   0 4.7.0-rc1-00005-g8238af6
10: omap3-beagle    : PASS   0 4.7.0-rc1-00005-g8238af6
11: am335x-boneblack: PASS   0 4.7.0-rc1-00005-g8238af6
12: am335x-bone     : PASS   0 4.7.0-rc1-00005-g8238af6
13: craneboard      : PASS   1 4.7.0-rc1-00005-g8238af6
14: dra72x-evm      : FAIL   3 4.7.0-rc1-00005-g8238af6
15: dra7xx-evm      : PASS   3 4.7.0-rc1-00005-g8238af6
16: ldp3430         : FAIL   0                         
17: omap3-n900      : PASS   0 4.7.0-rc1-00005-g8238af6
18: omap5-uevm      : PASS   0 4.7.0-rc1-00005-g8238af6
19: omap4-panda-es  : PASS   0 4.7.0-rc1-00005-g8238af6
20: omap4-panda     : PASS   0 4.7.0-rc1-00005-g8238af6
21: omap2430-sdp    : PASS   0 4.7.0-rc1-00005-g8238af6
22: omap3430-sdp    : PASS   0 4.7.0-rc1-00005-g8238af6
23: omap4-sdp-es23plus: PASS   0 4.7.0-rc1-00005-g8238af6
TOTAL = 23 boards, Booted Boards = 21, No Boot boards = 2

Does not generate any new boot warnings, or other visible side effects.

The two failing boards seem to be broken in the farm in general, as they
fail with any kernel.

Patches also available here:

tree: https://github.com/t-kristo/linux-pm.git
branch: 4.7-rc1-hwmod-fixes

-Tero

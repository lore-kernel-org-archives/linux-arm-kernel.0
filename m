From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 18 Oct 2012 12:20:02 +0300
Subject: [PATCHv9 0/8] ARM: OMAP4: core retention support
Message-ID: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:
- rebased on top of 3.7-rc1
- applies on top of latest func pwrst code (v6)
- added back patch #1 to this set (it wasn't queued yet after all)
- added patch #7 for fixing a bug in the functional pwrst code
- added patch #8 for fixing a regression with MUSB PHY power handling
  (not quite sure if this is the correct way to fix this or not)

Tested with omap4460 gp panda + omap4430 emu blaze boards, with cpuidle +
suspend.

Branch also available here:
git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.7-rc1-omap4-ret-v9

Branch contains also the local timer fix patch from Tony, otherwise
cpuidle does not work properly.

-Tero

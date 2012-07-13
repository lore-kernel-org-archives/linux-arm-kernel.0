From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 13 Jul 2012 17:19:37 +0300
Subject: [PATCHv4 0/8] ARM: OMAP: pm: usecounting changes
Message-ID: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:

- added kerneldoc comments to new API functions
- added autoidle flagging support for omap3 dplls
- modified the clkdm code tweak required to fix omap3 per domain problems
 * moved implementation to _clkdm_del_autodeps
 * renamed the CLKDM_SKIP_MANUAL_TRANS to CLKDM_NO_AUTODEP_DISABLE
 * modified comments accordingly
- ported for 3.5-rc6

- tested with omap3 beagle board, both ret / off + suspend / cpuidle

- functional branch available at:
  git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
  branch: mainline-3.5-rc6-pwrdm-changes-v4

-Tero

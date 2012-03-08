From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 12:53:29 -0800
Subject: [GIT PULL 1/7] non-critical fixes part3 for upcoming merge window
Message-ID: <pull-1331240009-558004>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Here are two more pre-emptive fixes for upcoming merge
window to pull into arm-soc/next/fixes-non-critical.

Now with the fixes finallny out of the way after all
the cleanup related changes, as a reply to this pull
request I'm posting some more pull requests for cleanup
and some minor board changes.

Regards,

Tony


The following changes since commit 9cf793f9b8b1ba9414e2a7591b2e911885f85a27:
  Kevin Hilman (1):
        ARM: OMAP: convert omap_device_build() and callers to __init

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical-part3

Tony Lindgren (2):
      ARM: OMAP2+: Fix section warnings for hsmmc_init_one
      ARM: OMAP2+: Fix build for omap4 only builds with missing include of linux/bug.h

 arch/arm/mach-omap2/hsmmc.c           |    2 +-
 arch/arm/mach-omap2/powerdomain44xx.c |    1 +
 arch/arm/mach-omap2/vc.c              |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

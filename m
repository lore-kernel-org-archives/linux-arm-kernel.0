From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 May 2013 16:46:11 -0700
Subject: [GIT PULL] Urgent omap timer fix for current merge window
Message-ID: <20130506234610.GK28721@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit dc2d3db8137fba0f62d7517e1bea8a47f69fcbc4:

  Merge tag 'omap-for-v3.10/timer-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/drivers (2013-04-08 19:30:48 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-for-merge-window

for you to fetch changes up to 08a48be32ff31d38bcfec7d210c954cb62fd5cd7:

  ARM: OMAP4: change the device names in usb_bind_phy (2013-05-06 16:39:16 -0700)

----------------------------------------------------------------
An urgent fix for a timer mismerge for and a regression fix for
musb device naming change.

----------------------------------------------------------------
Kishon Vijay Abraham I (1):
      ARM: OMAP4: change the device names in usb_bind_phy

Vaibhav Hiremath (1):
      ARM: OMAP2+: Fix mismerge for timer.c between ff931c82 and da4a686a

 arch/arm/mach-omap2/board-4430sdp.c    | 2 +-
 arch/arm/mach-omap2/board-omap4panda.c | 2 +-
 arch/arm/mach-omap2/timer.c            | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

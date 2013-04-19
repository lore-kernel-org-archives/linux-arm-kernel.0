From: olof@lixom.net (Olof Johansson)
Date: Fri, 19 Apr 2013 10:59:48 -0700
Subject: [GIT PULL] ARM: arm-soc fixes for 3.9
Message-ID: <20130419175948.GA29547@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 71bd98aff05a644a2cfc3ac6ca848a586fa210b9:

  Merge tag 'mvebu_fixes_for_v3.9_round3' of git://git.infradead.org/users/jcooper/linux into fixes (2013-04-11 16:55:29 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 73053d973dd6f56472309cffa5a5d15a62dd6f96:

  ARM: highbank: fix cache flush ordering for cpu hotplug (2013-04-18 09:37:46 -0700)

----------------------------------------------------------------
ARM: arm-soc fixes for 3.9

Only one remaining fix for arm-soc platforms at this time, a small
bugfix for cpu hotplug on highbank platforms that has become much
easier to hit as of late. Details in the patch description, but it's
small and well-contained and definitely impacts users of the platform,
so 3.9 seems appropriate.

----------------------------------------------------------------
Rob Herring (1):
      ARM: highbank: fix cache flush ordering for cpu hotplug

 arch/arm/mach-highbank/hotplug.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

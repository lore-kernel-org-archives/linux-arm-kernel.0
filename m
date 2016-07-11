From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Jul 2016 09:11:12 -0700
Subject: [GIT PULL] omap2plus_defconfig fix for v4.8 merge window
Message-ID: <20160711161112.GA28563@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/defconfig-v2-signed

for you to fetch changes up to 0992b2f16bc055df4fcd30558653490912637edd:

  ARM: omap2plus_defconfig: Fix USB selection to keep Ethernet working (2016-07-11 00:24:27 -0700)

----------------------------------------------------------------
A defconfig update for omap2plus_defconfig to fix changed USB
Kconfig dependencies for v4.8 merge window. Otherwise things
like USB Ethernet on omap3 beagle, omap4 panda and omap5-uevm
won't work without manual configuration.

----------------------------------------------------------------
Tony Lindgren (1):
      ARM: omap2plus_defconfig: Fix USB selection to keep Ethernet working

 arch/arm/configs/omap2plus_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

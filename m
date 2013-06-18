From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 11:07:27 -0700
Subject: [GIT PULL 6/7] omap gpmc reworked suspend patch for v3.11 merge window
In-Reply-To: <pull-1371578847-800598>
Message-ID: <mailman.7.1371578919.1060.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b3f5525c55ce5cb67af06f04dbbf28358da23a2c:

  ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable (2013-06-12 09:56:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/gpmc-part2-signed

for you to fetch changes up to b536dd412b4364df2f9495c6550ee38f6ad3b0fe:

  ARM: OMAP2+: gpmc: Low power transition support (2013-06-18 03:46:39 -0700)

----------------------------------------------------------------
GPMC suspend patch that was left out of the earlier
omap-for-v3.11/gpmc-signed branch because of a compile error
it caused. The compile error is fixed in this version.

----------------------------------------------------------------
avinash philip (1):
      ARM: OMAP2+: gpmc: Low power transition support

 arch/arm/mach-omap2/gpmc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

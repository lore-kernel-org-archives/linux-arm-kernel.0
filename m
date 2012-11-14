From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 13 Nov 2012 17:18:13 -0800
Subject: [GIT PULL] ARM: OMAP4: PM: basic support for core retention in suspend
Message-ID: <87zk2ldlt6.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.8-pm-omap4-core-ret

for you to fetch changes up to 4fd7a41233eac62b10ede394b35d8919086f94ec:

  ARM: OMAP4: USB: power down MUSB PHY during boot (2012-11-13 15:57:09 -0800)

----------------------------------------------------------------
Add support for full-chip retention in suspend for OMAP4 SoCs.

----------------------------------------------------------------
Rajendra Nayak (1):
      ARM: OMAP4: suspend: Program all domains to retention

Tero Kristo (1):
      ARM: OMAP4: USB: power down MUSB PHY during boot

 arch/arm/mach-omap2/omap_phy_internal.c | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm44xx.c            |  7 -------
 2 files changed, 32 insertions(+), 7 deletions(-)

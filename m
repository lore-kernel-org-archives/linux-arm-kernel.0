From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Nov 2012 18:56:44 -0800
Subject: [GIT PULL 5/5] omap full-chip retention in suspend for v3.8 merge
 window
In-Reply-To: <pull-1352948204-277861>
Message-ID: <mailman.6.1352948243.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 46bf4a562207c5ebd24e1dde5e5ee326cd3d6b91:

  Merge tag 'for_3.8-pm-voltage' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.8/pm (2012-11-06 17:06:37 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/pm-part2-v3-signed

for you to fetch changes up to 74d29168e9af59c9db1885e27493fbed4d24ef18:

  ARM: OMAP2+: voltage: fixup oscillator handling when CONFIG_PM=n (2012-11-14 17:21:15 -0800)

----------------------------------------------------------------
PM changes via Kevin Hilman <khilman@deeprootsystems.com>:

Add support for full-chip retention in suspend for OMAP4 SoCs

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: OMAP2+: voltage: fixup oscillator handling when CONFIG_PM=n

Rajendra Nayak (1):
      ARM: OMAP4: suspend: Program all domains to retention

Tero Kristo (1):
      ARM: OMAP4: USB: power down MUSB PHY during boot

Tony Lindgren (2):
      Merge tag 'for_3.8-pm-omap4-core-ret' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.8/pm-part2
      Merge branch 'omap-for-v3.8/pm' into omap-for-v3.8/pm-part2

 arch/arm/mach-omap2/omap_phy_internal.c | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                |  2 ++
 arch/arm/mach-omap2/pm.h                |  2 +-
 arch/arm/mach-omap2/pm44xx.c            |  7 -------
 arch/arm/mach-omap2/vc.c                |  2 ++
 5 files changed, 37 insertions(+), 8 deletions(-)

From: khilman@ti.com (Kevin Hilman)
Date: Wed, 02 Mar 2011 08:30:06 -0800
Subject: [GIT PULL] OMAP PM fixes for 2.6.38-rc
In-Reply-To: <87pqqae8mc.fsf@ti.com> (Kevin Hilman's message of "Tue, 01 Mar
	2011 15:14:35 -0800")
References: <87pqqae8mc.fsf@ti.com>
Message-ID: <8739n5eb8x.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Kevin Hilman <khilman@ti.com> writes:

> Here's a final batch of PM fixes for the 2.6.38-rc cycle.

I just noticed that a couple of these were already queued in your last
pull request to Linus.

Here's an updated pull request based on .38-rc7.

Kevin

The following changes since commit dd9c1549edef02290edced639f67b54a25abbe0e:

  Linux 2.6.38-rc7 (2011-03-01 13:55:12 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.38/pm-fixes

Aaro Koskinen (1):
      arm: mach-omap2: smartreflex: fix another memory leak

Shweta Gulati (1):
      OMAP2+: PM: SmartReflex: fix memory leaks in Smartreflex driver

 arch/arm/mach-omap2/smartreflex.c |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Dec 2009 13:21:22 +0000
Subject: [GIT PULL] Patches for 2.6.33-rc1
In-Reply-To: <20091209124933.GE9018@sirena.org.uk>
References: <1260353349.13499.4.camel@pc1117.cambridge.arm.com>
	<1260354044.19669.1267.camel@localhost>
	<1260355174.13499.8.camel@pc1117.cambridge.arm.com>
	<20091209124933.GE9018@sirena.org.uk>
Message-ID: <1260364882.13499.46.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-09 at 12:49 +0000, Mark Brown wrote:
> On Wed, Dec 09, 2009 at 10:39:34AM +0000, Catalin Marinas wrote:
> 
> > It would be useful, indeed, so I haven't seen an official statement
> from
> > Russell on this (and I usually run gitk on specific directories).
> 
> I'd suggest using ARM: like the patch system does.  In general looking
> at the logs for the directory/file you're updating and using the same
> prefix as most of the commits works well.

I updated the branch :-)


The following changes since commit 22763c5cf3690a681551162c15d34d935308c8d7:
  Linus Torvalds (1):
        Linux 2.6.32

are available in the git repository at:

  git://linux-arm.org/linux-2.6.git for-rmk

Catalin Marinas (2):
      ARM: Add an earlyprintk debug console
      ARM: RealView: Fix typo in the RealView/PBX Kconfig entry

Varun Swara (1):
      ARM: Do not allow the probing of the local timer

 arch/arm/Kconfig.debug         |    8 +++++
 arch/arm/kernel/Makefile       |    1 +
 arch/arm/kernel/early_printk.c |   57 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/smp_twd.c      |    1 +
 arch/arm/mach-realview/Kconfig |    2 +-
 5 files changed, 68 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/kernel/early_printk.c

-- 
Catalin

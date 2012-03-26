From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Mar 2012 10:19:47 -0600
Subject: [GIT PULL] ARM: tegra: Include assembler.h in sleep.S to fix build
 break
Message-ID: <4F709723.4080206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This pull request depends on the merge of:

git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
devel/io-cleanup
(specifically 6f6f6a7 ARM: create a common IOMEM definition)

and:

git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.4/soc
(specifically c76fcc8 ARM: tegra: assembler code for LP3)

and is based on a local branch that merges the two branches above.

The following changes since commit 1ad105fc77e61f9dd7a272659a248e2979fdb893:
  Stephen Warren (1):
        Merge remote branch 'remotes/korg_olof_tegra/for-3.4/soc' into
for-3.4/fixes-for-io-cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.4/fixes-for-io-cleanup

Stephen Warren (1):
      ARM: tegra: Include assembler.h in sleep.S to fix build break

 arch/arm/mach-tegra/sleep.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

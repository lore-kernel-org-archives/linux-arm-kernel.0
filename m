From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  6 Jul 2012 10:46:44 -0600
Subject: [GIT PULL 3/7] ARM: tegra: for-3.6/soc branch
In-Reply-To: <1341593208-17914-1-git-send-email-swarren@wwwdotorg.org>
References: <1341593208-17914-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1341593208-17914-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains changes to Tegra SoC-specific code in the mach-tegra
directory; only 1 patch this time around.

This branch is based on Tegra's for-3.6/fixes branch from the previous pull
request.

This branch is not included in any later pull requests.

----------------------------------------------------------------

The following changes since commit 8994c34c194d5f59f014d3c3b90eb677672ddb03:

  ARM: tegra: apbio access using dma for tegra20 only

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git for-3.6/soc

for you to fetch changes up to b55a55ca96e5ab22893f01b450f8dbe4972e58e6:

  ARM: tegra: apbio: use dmaengine based dma driver

----------------------------------------------------------------

Laxman Dewangan (1):
      ARM: tegra: apbio: use dmaengine based dma driver

 arch/arm/mach-tegra/apbio.c |  139 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 135 insertions(+), 4 deletions(-)

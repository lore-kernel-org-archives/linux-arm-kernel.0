From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:05 -0700
Subject: [GIT PULL 03/10] ARM: tegra: dependency 2 from the DMA tree
In-Reply-To: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
References: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387231812-5701-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch introduces the dma_get_any_slave_channel() API, and is a
dependency for Tegra's conversion to use the common/standard DMA
DT bindings.

Note that Vinod didn't create a signed tag for this branch, but is aware
that I'm pulling this branch into the Tegra tree.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>

----------------------------------------------------------------

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1

are available in the git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git topic/of

or:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-3.14/deps-from-dma-of

for you to fetch changes up to 8010dad55a0ab0e829f3733854e5235eef4e2734:

  dma: add dma_get_any_slave_channel(), for use in of_xlate()

----------------------------------------------------------------

Stephen Warren (1):
      dma: add dma_get_any_slave_channel(), for use in of_xlate()

 drivers/dma/dmaengine.c   | 28 ++++++++++++++++++++++++++++
 drivers/dma/mmp_pdma.c    | 30 +++++++-----------------------
 include/linux/dmaengine.h |  1 +
 3 files changed, 36 insertions(+), 23 deletions(-)

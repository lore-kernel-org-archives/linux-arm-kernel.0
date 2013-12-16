From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:03 -0700
Subject: [GIT PULL 01/10] ARM: tegra: dependency 1 from the DMA tree
Message-ID: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch introduces the dma_request_slave_channel_reason() API, and
is a dependency for Tegra's conversion to use the common/standard DMA
DT bindings.

Note that Vinod didn't create a signed tag for this branch, but has
certainly given his OK in email for me to pull this branch into the
Tegra tree. Mark has also pulled it into the ASoC tree.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>

----------------------------------------------------------------

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1

are available in the git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git topic/defer_probe

or:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-3.14/deps-from-dma-defer_probe

for you to fetch changes up to 0ad7c00057dc1640647c1dc81ccbd009de17a767:

  dma: add channel request API that supports deferred probe

----------------------------------------------------------------

Stephen Warren (1):
      dma: add channel request API that supports deferred probe

 drivers/dma/dmaengine.c   | 35 +++++++++++++++++++++++++++++++----
 drivers/dma/of-dma.c      | 15 +++++++++------
 include/linux/dmaengine.h |  8 ++++++++
 3 files changed, 48 insertions(+), 10 deletions(-)

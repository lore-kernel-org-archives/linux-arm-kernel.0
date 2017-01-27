From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jan 2017 10:21:18 +0100
Subject: [GIT PULL 1/4] memory: tegra: Changes for v4.11-rc1
Message-ID: <20170127092121.21570-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.11-memory

for you to fetch changes up to b92f4380a1c7eb3ed19d6f68ad7b66c66d8102b4:

  memory: tegra: Add a missing 'of_node_put()' call (2017-01-25 07:57:13 +0100)

Thanks,
Thierry

----------------------------------------------------------------
memory: tegra: Changes for v4.11-rc1

This contains a single commit that plugs a potential device node leak in
error handling code.

----------------------------------------------------------------
Christophe Jaillet (1):
      memory: tegra: Add a missing 'of_node_put()' call

 drivers/memory/tegra/tegra124-emc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

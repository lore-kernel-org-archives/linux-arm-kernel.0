From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Jul 2018 17:41:25 +0200
Subject: [GIT PULL 2/5] memory: tegra: Changes for v4.19-rc1
In-Reply-To: <20180712154128.22705-1-thierry.reding@gmail.com>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
Message-ID: <20180712154128.22705-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.19-memory

for you to fetch changes up to 1662dd641f596e5517c7b7a23e4f8ddf36741b5f:

  memory: tegra: Correct driver probe order (2018-07-10 17:29:15 +0200)

Thanks,
Thierry

----------------------------------------------------------------
memory: tegra: Changes for v4.19-rc1

This contains a single fix for the initialization order of the various
parts of the Tegra memory controller driver.

----------------------------------------------------------------
Dmitry Osipenko (1):
      memory: tegra: Correct driver probe order

 drivers/memory/tegra/mc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

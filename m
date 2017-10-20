From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Oct 2017 13:55:58 +0200
Subject: [GIT PULL 2/7] firmware: tegra: Changes for v4.15-rc1
In-Reply-To: <20171020115603.9828-1-thierry.reding@gmail.com>
References: <20171020115603.9828-1-thierry.reding@gmail.com>
Message-ID: <20171020115603.9828-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.15-firmware

for you to fetch changes up to f2381f652266fabfb7a8f5c4b2a05de36cad3a73:

  firmware: tegra: Add BPMP debugfs support (2017-10-19 16:27:56 +0200)

Thanks,
Thierry

----------------------------------------------------------------
firmware: tegra: Changes for v4.15-rc1

This contains a couple of (non-critical) fixes and improvements for the
BPMP driver as well as support for debugfs.

----------------------------------------------------------------
Mikko Perttunen (2):
      firmware: tegra: Expose tegra_bpmp_mrq_return()
      firmware: tegra: Add stubs when BPMP not enabled

Timo Alho (2):
      firmware: tegra: Propagate error code to caller
      firmware: tegra: Add BPMP debugfs support

 drivers/firmware/tegra/Makefile       |   4 +-
 drivers/firmware/tegra/bpmp-debugfs.c | 444 ++++++++++++++++++++++++++++++++++
 drivers/firmware/tegra/bpmp.c         |  31 ++-
 include/soc/tegra/bpmp.h              |  59 ++++-
 4 files changed, 526 insertions(+), 12 deletions(-)
 create mode 100644 drivers/firmware/tegra/bpmp-debugfs.c

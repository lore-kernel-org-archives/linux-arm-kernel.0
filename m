From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Mar 2018 15:18:46 +0100
Subject: [GIT PULL 3/7] firmware: Changes for v4.17-rc1
In-Reply-To: <20180316141850.4876-1-thierry.reding@gmail.com>
References: <20180316141850.4876-1-thierry.reding@gmail.com>
Message-ID: <20180316141850.4876-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-firmware

for you to fetch changes up to 1320f76897c5e4893aff68d0bfc1797a5ba543ff:

  firmware: tegra: adjust tested variable (2018-03-08 14:43:13 +0100)

Thanks,
Thierry

----------------------------------------------------------------
firmware: Changes for v4.17-rc1

These changes are rather small, with just a fix for a return value check
and some preparatory work for Tegra194 BPMP support.

----------------------------------------------------------------
Julia Lawall (1):
      firmware: tegra: adjust tested variable

Mikko Perttunen (1):
      firmware: tegra: Simplify channel management

 drivers/firmware/tegra/bpmp.c | 144 +++++++++++++++++++-----------------------
 include/soc/tegra/bpmp.h      |   4 +-
 2 files changed, 67 insertions(+), 81 deletions(-)

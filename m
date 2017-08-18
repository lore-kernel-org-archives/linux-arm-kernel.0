From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 16:48:04 +0200
Subject: [GIT PULL 3/5] ARM: tegra: Changes for v4.14-rc1
In-Reply-To: <20170818144806.14252-1-thierry.reding@gmail.com>
References: <20170818144806.14252-1-thierry.reding@gmail.com>
Message-ID: <20170818144806.14252-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.14-arm-core

for you to fetch changes up to 6aa26c5d66595494e810c791602d87a572c78808:

  ARM: tegra: Select appropriate DMA options for LPAE (2017-07-31 18:59:44 +0200)

----------------------------------------------------------------
ARM: tegra: Changes for v4.14-rc1

Contains a single fix for platforms with more than 2 GiB of memory
running on a kernel with LPAE enabled.

----------------------------------------------------------------
Paul Kocialkowski (1):
      ARM: tegra: Select appropriate DMA options for LPAE

 arch/arm/mach-tegra/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

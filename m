From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jan 2017 10:21:19 +0100
Subject: [GIT PULL 2/4] ARM: tegra: Core SoC changes for v4.11-rc1
In-Reply-To: <20170127092121.21570-1-thierry.reding@gmail.com>
References: <20170127092121.21570-1-thierry.reding@gmail.com>
Message-ID: <20170127092121.21570-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.11-soc

for you to fetch changes up to ed0a27ef6411b22c75ae596ca2722dd7b621bcd0:

  ARM: tegra: paz00: Fix __initdata placement (2017-01-25 09:09:32 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Core SoC changes for v4.11-rc1

This contains a single cleanup patch for the placement of the __initdata
annotation, as suggested by checkpatch.

----------------------------------------------------------------
Dmitry Torokhov (1):
      ARM: tegra: paz00: Fix __initdata placement

 arch/arm/mach-tegra/board-paz00.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

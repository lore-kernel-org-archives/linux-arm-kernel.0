From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 16:48:02 +0200
Subject: [GIT PULL 1/5] firmare: Changes for v4.14-rc1
Message-ID: <20170818144806.14252-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.14-firmware

for you to fetch changes up to 122954edfdf5888dbd532acf2b945af15660da66:

  firmware: tegra: set drvdata earlier (2017-08-17 13:08:08 +0200)

----------------------------------------------------------------
firmare: Changes for v4.14-rc1

This contains a single bug fix that can lead to a crash in some rare
situations. Since this has never been reported to happen with the level
of support that exists upstream, this isn't considered critical.

----------------------------------------------------------------
Timo Alho (1):
      firmware: tegra: set drvdata earlier

 drivers/firmware/tegra/bpmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

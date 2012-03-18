From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Mar 2012 10:50:20 -0700
Subject: [GIT PULL] Refresh of board branch for tegra
Message-ID: <CAOesGMh9hp12fwNQ4QwStg3yc-DXnixj4wHNOjO1rHeX8hJnxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

One more patch has been added to the board branch, just a defconfig
update to mostly include some of the new drivers that have been added
lately, etc.


The following changes since commit c5444f39620b2b7801eb1997c41befdc8bcf78ea:

  ARM: tegra: match SoC name not board name in DT board files
(2012-03-04 10:41:19 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.4/boards

for you to fetch changes up to 0a25893597dfbad08aff833bdefac2fe5b31aabd:

  ARM: tegra: update defconfig (2012-03-07 14:38:49 -0800)

----------------------------------------------------------------
Stephen Warren (1):
      ARM: tegra: update defconfig

 arch/arm/configs/tegra_defconfig |   33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)
